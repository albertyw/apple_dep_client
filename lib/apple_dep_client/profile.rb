# Methods for getting and setting device profiles

require "json"

module AppleDEPClient
  module Profile
    DEFINE_PATH = "/profile"
    ASSIGN_PATH = "/profile/devices"
    FETCH_PATH = "/profile"
    REMOVE_PATH = "/profile/devices"

    PROFILE_KEYS = [:profile_name, :url, :allow_pairing, :is_supervised,
                    :is_mandatory, :await_device_configured, :is_mdm_removable, :support_phone_number,
                    :support_email_address, :org_magic, :anchor_certs, :supervising_host_certs,
                    :skip_setup_items, :department, :devices]

    def self.define(profile_data)
      profile_data.select! { |key, _value| PROFILE_KEYS.include? key.to_sym }
      profile_data = JSON.dump profile_data
      AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(DEFINE_PATH), :post, profile_data)
    end

    def self.assign(profile_uuid, devices)
      body = { "profile_uuid" => profile_uuid, "devices" => devices }
      body = JSON.dump body
      AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(ASSIGN_PATH), :put, body)
    end

    def self.fetch(profile_uuid)
      params = { "profile_uuid" => profile_uuid }
      AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(FETCH_PATH), :get, nil, params: params)
    end

    def self.remove(devices)
      body = { "devices" => devices }
      body = JSON.dump body
      AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(REMOVE_PATH), :delete, body)
    end
  end
end
