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

    # Used by AppleDEPClient::Request
    class MalformedRequest < RequestError
    end
    class Unauthorized < RequestError
    end
    class Forbidden < RequestError
    end
    class MethodNotAllowed < RequestError
    end

    # Used by AppleDEPClient::Device
    class InvalidCursor < RequestError
    end
    class ExhaustedCursor < RequestError
    end
    class CursorRequired < RequestError
    end
    class ExpiredCursor < RequestError
    end
    class NotFound < RequestError
    end
    class DeviceIDRequired < RequestError
    end
  end
end
