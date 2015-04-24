# Errors for AppleDEPClient and Apple's endpoints

module AppleDEPClient
  module Error
    class RequestError < RuntimeError
      attr_reader :body
      def initialize(body)
        @body = body
      end
    end
    # Used by AppleDEPClient::Auth
    class AuthBadRequest < RequestError
    end
    class AuthUnauthorized < RequestError
    end
    class AuthForbidden < RequestError
    end
  end
end
