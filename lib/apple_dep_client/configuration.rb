# Configuration for AppleDEPClient
# Configuration values can be either literals or Procs; note that Procs will not
# be overwritten by AppleDEPClient::Token.save_data

module AppleDEPClient
  module Configuration
    DEP_CONFIG = {
      private_key: nil,         # MDM Server's private key for decrypting token files
      consumer_key: nil,        # Server Token information
      consumer_secret: nil,
      access_token: nil,
      access_secret: nil,
      access_token_expiry: nil,
      apple_dep_server: "https://mdmenrollment.apple.com", # Domain that Apple's DEP servers are at
      user_agent: "CellabusMDM",
    }

    DEP_CONFIG.freeze

    attr_writer *DEP_CONFIG.keys

    def method_missing(m, *_args, &_block)
      if DEP_CONFIG.keys.include? m.to_sym
        get_value(m)
      else
        raise NoMethodError, "Unknown method #{m}"
      end
    end

    def get_value(m)
      value = instance_variable_get("@#{m}")
      value = get_default_value(m) if value.nil?
      (value.is_a? Proc) ? value.call : value
    end

    def get_default_value(key)
      DEP_CONFIG[key.to_sym]
    end

    def configure
      yield self
    end
  end
end
