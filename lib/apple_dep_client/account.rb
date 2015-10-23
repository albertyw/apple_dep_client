# Methods for getting and setting DEP account details

module AppleDEPClient
  module Account
    FETCH_PATH = "/account"
    def self.fetch
      AppleDEPClient::Request.make_request(AppleDEPClient::Request.make_url(FETCH_PATH), :get, "")
    end
  end
end
