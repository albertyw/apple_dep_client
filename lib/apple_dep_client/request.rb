# Wrapper around requests to DEP endpoint
# Will also handle any error conditions

require "json"
require "typhoeus"

module AppleDEPClient
  module Request
    DEFAULT_HEADERS = {
      "User-Agent" => "#{AppleDEPClient.user_agent}/#{AppleDEPClient::VERSION}",
      "X-Server-Protocol-Version" => "2",
      "Content-Type" => "application/json;charset=UTF8",
    }
    DEFAULT_HEADERS.freeze

    def self.make_request(url, query_type, body, params:nil, headers:nil)
      if headers == nil
        headers = make_headers
      end
      request = Typhoeus::Request.new(
        url,
        method: query_type,
        body: body,
        params: params,
        headers: headers,
      )
      request.run
      AppleDEPClient::Error.check_request_error request.response
      JSON.parse request.response.body
    end

    def self.make_headers
      session_auth_token = AppleDEPClient::Auth.get_session_token
      DEFAULT_HEADERS.merge("X-ADM-Auth-Session" => session_auth_token)
    end

    def self.make_url(path)
      AppleDEPClient.apple_dep_server + path
    end
  end
end
