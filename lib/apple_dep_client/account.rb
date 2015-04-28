# Methods for getting and setting DEP account details

module AppleDEPClient
  module Account
    URL = "#{AppleDEPClient.apple_dep_server}/account"
    def self.fetch
      AppleDEPClient::Request.make_request(URL, :get, '')
    end
  end
end
