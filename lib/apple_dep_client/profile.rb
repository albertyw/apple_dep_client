# Methods for getting and setting device profiles

require 'json'

module AppleDEPClient
  module Profile
    DEFINE_URL = "#{AppleDEPClient.apple_dep_server}/profile"
    ASSIGN_URL = "#{AppleDEPClient.apple_dep_server}/profile/devices"
    FETCH_URL = "#{AppleDEPClient.apple_dep_server}/profile"

    PROFILE_KEYS = [:profile_name, :url, :allow_pairing, :is_supervised,
      :is_mandatory, :is_mdm_removable, :support_phone_number,
      :support_email_address, :org_magic, :anchor_certs, :supervising_host_certs,
      :skip_setup_items, :department, :devices]

    def self.define(profile_data)
      profile_data.select!{|key, value| PROFILE_KEYS.include? key.to_sym}
      profile_data = JSON.dump profile_data
      AppleDEPClient::Request.make_request(DEFINE_URL, :post, profile_data)
    end

    def self.assign(profile_uuid, devices)
      body = {"profile_uuid" => profile_uuid, "devices" => devices}
      body = JSON.dump body
      AppleDEPClient::Request.make_request(ASSIGN_URL, :put, body)
    end

    def self.fetch(profile_uuid)
      params = {'profile_uuid' => profile_uuid}
      AppleDEPClient::Request.make_request(FETCH_URL, :get, nil, params:params)
    end

    def self.remove(devices)
      raise NotImplementedError
    end
  end
end
