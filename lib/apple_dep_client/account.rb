# Methods for getting and setting DEP account details

module AppleDEPClient
  module Account
    URL = 'https://mdmenrollment.apple.com/account'
    def self.fetch
      AppleDEPClient::Request.make_request(URL, :get, '')
    end
  end
end
