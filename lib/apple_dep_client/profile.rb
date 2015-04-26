# Methods for getting and setting device profiles

require 'json'

module AppleDEPClient
  module Profile
    def self.define(data)
      raise NotImplementedError
    end

    def self.assign(profile_uuid, devices)
      raise NotImplementedError
    end

    def self.fetch(profile_uuid)
      raise NotImplementedError
    end

    def self.remove(devices)
      raise NotImplementedError
    end
  end
end
