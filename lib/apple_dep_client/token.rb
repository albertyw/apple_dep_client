require 'json'
require 'openssl'

module AppleDEPClient
  module Token
    # Given an S/MIME encrypted Server Token, return a hash of token values
    # From the MDM Protocol information, it seems all tokens are PKCS7-MIME encrypted
    def self.decode_token(smime_data)
      pkcs = OpenSSL::PKCS7.read_smime(smime_data)
      data = pkcs.decrypt(AppleDEPClient.private_key)
      parse_data data
    end

    def self.parse_data(data)
      data = JSON.parse(data, {symbolize_names: true})
      save_data data
      data
    end

    def self.save_data(data)
      AppleDEPClient.consumer_key = data[:consumer_key]
      AppleDEPClient.consumer_secret = data[:consumer_secret]
      AppleDEPClient.access_token = data[:access_token]
      AppleDEPClient.access_secret = data[:access_secret]
      AppleDEPClient.access_token_expiry = data[:access_token_expiry]
    end
  end
end
