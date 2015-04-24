# Errors for AppleDEPClient and Apple's endpoints

module AppleDEPClient
  module Error
    def self.check_request_error response
      get_error_classes.each do |c|
        if c.check_response response
          raise c.new response.body
        end
      end
    end

    def self.get_error_classes
      classes = constants.map {|c| const_get(c)}
      classes.select!{|c| c < AbstractRequestError and c != AppleDEPClient::Error::GenericError}
      classes + [AppleDEPClient::Error::GenericError] # Add AbstractRequestError at the end
    end

    class AbstractRequestError < RuntimeError
      # Error class that all other errors inherit from
      # This shouldn't ever be instantiated
      attr_reader :body
      def initialize(body)
        @body = body
      end
      def self.check_response response
        raise NotImplementedError
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
      def self.check_response response
        response.code != 200
      end
    end

    # Used by AppleDEPClient::Request
    class MalformedRequest < AbstractRequestError
      def self.check_response response
        response.code == 400 and response.body.strip == 'MALFORMED_REQUEST_BODY'
      end
    end
    class Unauthorized < AbstractRequestError
      def self.check_response response
        response.code == 401 and response.body.strip == 'UNAUTHORIZED'
      end
    end
    class Forbidden < AbstractRequestError
      def self.check_response response
        response.code == 403 and response.body.strip == 'FORBIDDEN'
      end
    end
    class MethodNotAllowed < AbstractRequestError
      def self.check_response response
        response.code == 405
      end
    end

    # Used by AppleDEPClient::Device
    class InvalidCursor < AbstractRequestError
      def self.check_response response
        response.code == 400 and response.body.strip == 'INVALID_CURSOR'
      end
    end
    class ExhaustedCursor < AbstractRequestError
      def self.check_response response
        response.code == 400 and response.body.strip == 'EXHAUSTED_CURSOR'
      end
    end
    class CursorRequired < AbstractRequestError
      def self.check_response response
        response.code == 400 and response.body.strip == 'CURSOR_REQUIRED'
      end
    end
    class ExpiredCursor < AbstractRequestError
      def self.check_response response
        response.code == 400 and response.body.strip == 'EXPIRED_CURSOR'
      end
    end
    class NotFound < AbstractRequestError
      def self.check_response response
        response.code == 200 and response.body.strip == 'NOT_FOUND'
      end
    end
    class DeviceIDRequired < AbstractRequestError
      def self.check_response response
        response.code == 400 and response.body.strip == 'DEVICE_ID_REQUIRED'
      end
    end
  end
end
