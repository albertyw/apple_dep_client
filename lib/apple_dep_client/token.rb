# Methods for processing DEP Server Tokens

require "json"
require "open3"
require "openssl"
require "tempfile"

module AppleDEPClient
  module Token
    SERVER_TOKEN_KEYS = [:consumer_key, :consumer_secret, :access_token, :access_secret, :access_token_expiry]
    SERVER_TOKEN_KEYS.freeze

    # Given an S/MIME encrypted Server Token, return a hash of token values
    # From the MDM Protocol information, it seems all tokens are PKCS7-MIME encrypted
    def self.decode_token(smime_data)
      data = decrypt_data(smime_data)
      parse_data data
    end

    def self.decrypt_data(smime_data)
      data = create_temp_file("data", smime_data)
      private_key = create_temp_file("key", AppleDEPClient.private_key)
      command = "openssl smime -decrypt -in #{data.path} -inkey #{private_key.path} -text"
      decrypted_data, errors = run_command command
      remove_temp_file data
      remove_temp_file private_key
      if decrypted_data == "" || errors != ""
        raise AppleDEPClient::Error::TokenError, "Incorrect data #{errors}"
      end
      decrypted_data
    end

    def self.create_temp_file(name, data, binary: false)
      file = Tempfile.new name
      file.binmode if binary
      file.write data
      file.size # flush data to disk
      file
    end

    def self.remove_temp_file(file)
      file.close
      file.unlink
    end

    def self.run_command(command)
      stdin, stdout, stderr = Open3.popen3 command
      [stdout.read, stderr.read]
    end

    def self.parse_data(data)
      data = strip_wrappers data
      data = JSON.parse(data, symbolize_names: true)
      save_data data
      data
    end

    def self.strip_wrappers(data)
      data = data.sub("-----BEGIN MESSAGE-----", "").sub("-----END MESSAGE-----", "")
      data.strip
    end

    def self.save_data(data)
      SERVER_TOKEN_KEYS.each do |k|
        if not AppleDEPClient.instance_variable_get("@#{k}").respond_to? :call
          AppleDEPClient.instance_variable_set("@#{k}", data[k])
        end
      end
    end
  end
end
