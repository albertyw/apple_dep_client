# Methods for getting and setting device details

require "json"

module AppleDEPClient
  module Device
    FETCH_PATH = "/server/devices"
    FETCH_LIMIT = 1000 # must be between 100 and 1000
    SYNC_PATH = "/devices/sync"
    DETAILS_PATH = "/devices/details"
    DISOWN_PATH = "/devices/disown"

    def self.fetch(cursor: nil, url: nil)
      url ||= FETCH_PATH
      response = { "cursor" => cursor, "more_to_follow" => "true" }
      while response["more_to_follow"] == "true"
        response = make_fetch_request response["cursor"], url
        response["devices"].each do |device|
          yield device
        end
      end
      response["cursor"]
    end

    def self.make_fetch_request(cursor, url)
      body = fetch_body(cursor)
      AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(url), :post, body)
    end

    def self.fetch_body(cursor)
      body = { "limit" => FETCH_LIMIT }
      if cursor
        body["cursor"] = cursor
      end
      JSON.dump body
    end

    def self.sync(cursor, &block)
      fetch(cursor: cursor, url: SYNC_PATH, &block)
    end

    def self.details(devices)
      body = devices
      body = JSON.dump body
      response = AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(DETAILS_PATH), :post, body)
      response["devices"]
    end

    # Accepts an array of device ID strings
    # WARNING - this will remove devices from DEP accounts and
    # may render devices permanently inoperable
    # DEPRECATED by Apple
    def self.disown(devices)
      Kernel.warn "Disown is a deprecated request and may not be supported in the future"
      body = { "devices" => devices }
      body = JSON.dump body
      response = AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(DISOWN_PATH), :post, body)
      response["devices"]
    end
  end
end
