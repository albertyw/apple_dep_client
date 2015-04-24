# Apple Session Authorization Token management

require 'json'
require 'oauth'
require File.join(File.dirname(__FILE__), 'hacks', 'typhoeus_request')
require 'securerandom'
require 'typhoeus'

module AppleDEPClient
  module Auth
    # Apple requires a quirky OAuth 1.0a authentication to get a temporary
    # X-ADM-Auth-Session key to make requests; this takes care of that

    OAUTH_URL = 'https://mdmenrollment.apple.com/session'

    def self.get_session_token
      options = {method: :get, headers: {}}
      request = Typhoeus::Request.new(OAUTH_URL, options)
      request.options[:headers].merge!({'Authorization' => oauth_header(request)})
      request.run
      response = request.response
      if response.success?
        parse_response response
      else
        parse_error response
      end
    end

    def self.oauth_header request
      consumer = OAuth::Consumer.new(
        AppleDEPClient.consumer_key,
        AppleDEPClient.consumer_secret,
        site: OAUTH_URL
      )
      token = OAuth::AccessToken.new(
        consumer,
        AppleDEPClient.access_token,
        AppleDEPClient.access_secret,
      )
      oauth_params = {
        consumer: consumer,
        realm: 'ADM',
        token: token,
      }
      oauth_helper = OAuth::Client::Helper.new request, oauth_params.merge(request_uri: OAUTH_URL)
      oauth_helper.header
    end

    def self.parse_response response
      body = JSON.parse response.response_body
      auth_session_token = body['auth_session_token']
    end

    def self.parse_error response
      case response.code
      when 400
        raise AppleDEPClient::Error::AuthBadRequest.new response.body
      when 401
        raise AppleDEPClient::Error::AuthUnauthorized.new response.body
      when 403
        raise AppleDEPClient::Error::AuthForbidden.new response.body
      else
        raise AppleDEPClient::Error::RequestError.new response.body
      end
    end
  end
end
