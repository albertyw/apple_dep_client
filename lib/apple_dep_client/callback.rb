# Processing the device callback

require "plist"

module AppleDEPClient
  module Callback
    # Given an XML plist that is CMS-signed and DER encoded, return a ruby Hash
    # of the data
    def self.decode_callback(callback_data)
      data = decrypt_data callback_data
      parse_data data
    end

    def self.decrypt_data(callback_data)
      data = AppleDEPClient::Token.create_temp_file("data", callback_data, binary: true)
      command = "openssl asn1parse -inform DER -in #{data.path}"
      decrypted_data, errors = AppleDEPClient::Token.run_command command
      AppleDEPClient::Token.remove_temp_file data
      if decrypted_data == "" || errors != ""
        raise AppleDEPClient::Error::CallbackError, "Incorrect data #{errors}"
      end
      remove_encryption_data(decrypted_data)
    end

    # This is a bit hacky, because there doesn't seem to be a good way to decrypt
    # and clean the data
    def self.remove_encryption_data(callback_data)
      callback_data = callback_data.split
      read = false
      callback_data.select! do |line|
        if line.include? "<!DOCTYPE"
          read = true
        end
        read_line = read
        if line.include? "</plist>"
          read = false
        end
        read_line
      end
      callback_data.join("\n")
    end

    def self.parse_data(data)
      Plist::parse_xml(data)
    end
  end
end
