# Errors for AppleDEPClient and Apple's endpoints

module AppleDEPClient
  module Error
    class AbstractRequestError < RuntimeError
      # Error class that all other errors inherit from
      # This shouldn't ever be instantiated
      attr_reader :body
      def initialize(body)
        @body = body
      end
    end

    module Auth
      # Used by AppleDEPClient::Auth
      class BadRequest < AbstractRequestError
      end
      class Unauthorized < AbstractRequestError
      end
      class Forbidden < AbstractRequestError
      end
    end


    class GenericError < AbstractRequestError
      # Catch-all error class
    end

    # Used by AppleDEPClient::Request
    class MalformedRequest < AbstractRequestError
    end
    class Unauthorized < AbstractRequestError
    end
    class Forbidden < AbstractRequestError
    end
    class MethodNotAllowed < AbstractRequestError
    end

    # Used by AppleDEPClient::Device
    class InvalidCursor < AbstractRequestError
    end
    class ExhaustedCursor < AbstractRequestError
    end
    class CursorRequired < AbstractRequestError
    end
    class ExpiredCursor < AbstractRequestError
    end
    class NotFound < AbstractRequestError
    end
    class DeviceIDRequired < AbstractRequestError
    end
  end
end
