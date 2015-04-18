# Methods for processing DEP Server Tokens

require 'json'
require 'openssl'

module AppleDEPClient
  module Token
    SERVER_TOKEN_KEYS = [:consumer_key, :consumer_secret, :access_token, :access_secret, :access_token_expiry]
    SERVER_TOKEN_KEYS.freeze

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
      SERVER_TOKEN_KEYS.each do |k|
        AppleDEPClient.instance_variable_set("@#{k}", data[k])
      end
    end
  end
end
