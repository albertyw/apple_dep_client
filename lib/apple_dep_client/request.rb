# Wrapper around requests to DEP endpoint

require 'json'
require 'typhoeus'

module AppleDEPClient
  module Request

    def self.make_request(url, query_type, body, headers=nil)
      if headers == nil
        headers = make_headers
      end
      request = Typhoeus::Request.new(
        url,
        method: query_type,
        body: body,
        headers: headers
      )
      request.run
      AppleDEPClient::Error.check_request_error request.response
      JSON.parse request.response.body
    end

    def self.make_headers
      session_auth_token = AppleDEPClient::Auth.get_session_token
      {
        'User-Agent' => "CellabusMDM/#{AppleDEPClient::VERSION}",
        'X-Server-Protocol-Version' => '2',
        'X-ADM-Auth-Session' => session_auth_token,
        'Content-Type' => 'application/json;charset=UTF8',
      }
    end
  end
end
