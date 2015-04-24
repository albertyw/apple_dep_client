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
      check_response request.response
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

    def self.check_response response
      if response.code == 400 and response.body.strip == 'MALFORMED_REQUEST_BODY'
        raise AppleDEPClient::Error::MalformedRequest.new response.body
      elsif response.code == 401 and response.body.strip == 'UNAUTHORIZED'
        raise AppleDEPClient::Error::Unauthorized.new response.body
      elsif response.code == 403 and response.body.strip == 'FORBIDDEN'
        raise AppleDEPClient::Error::Forbidden.new response.body
      elsif response.code == 405
        raise AppleDEPClient::Error::MethodNotAllowed.new response.body
      elsif response.code != 200
        raise AppleDEPClient::Error::RequestError.new response.body
      end
    end
  end
end
