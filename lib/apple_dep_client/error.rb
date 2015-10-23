# Errors for AppleDEPClient and Apple's endpoints

module AppleDEPClient
  module Error
    AUTH_ERRORS = [
      # Used by AppleDEPClient::Auth
      ["BadRequest",          400, ""],
      ["Unauthorized",        401, ""],
      ["Forbidden",           403, ""],
    ]

    ERRORS = [
      # Used by AppleDEPClient::Request
      ["MalformedRequest",    400, "MALFORMED_REQUEST_BODY"],
      ["Unauthorized",        401, "UNAUTHORIZED"],
      ["Forbidden",           403, "FORBIDDEN"],
      ["MethodNotAllowed",    405, ""],

      # Used by AppleDEPClient::Device
      ["InvalidCursor",       400, "INVALID_CURSOR"],
      ["ExhaustedCursor",     400, "EXHAUSTED_CURSOR"],
      ["CursorRequired",      400, "CURSOR_REQUIRED"],
      ["ExpiredCursor",       400, "EXPIRED_CURSOR"],
      ["NotFound",            200, "NOT_FOUND"],
      ["DeviceIDRequired",    400, "DEVICE_ID_REQUIRED"],

      # Used by AppleDEPClient::Profile
      ["ConfigUrlRequired",   400, "CONFIG_URL_REQUIRED"],
      ["ConfigNameRequired",  400, "CONFIG_NAME_REQUIRED"],
      ["FlagsInvalid",        400, "FLAGS_INVALID"],
      ["ConfigUrlInvalid",    400, "CONFIG_URL_INVALID"],
      ["ConfigNameInvalid",   400, "CONFIG_NAME_INVALID"],
      ["DepartmentInvalid",   400, "DEPARTMENT_INVALID"],
      ["SupportPhoneInvalid", 400, "SUPPORT_PHONE_INVALID"],
      ["SupportEmailInvalid", 400, "SUPPORT_EMAIL_INVALID"],
      ["DescriptionInvalid",  400, "DESCRIPTION_INVALID"],
      ["MagicInvalid",        400, "MAGIC_INVALID"],
      ["ProfileUUIDRequired", 400, "PROFILE_UUID_REQUIRED"],
      ["ProfileNotFound",     404, "PROFILE_NOT_FOUND"],
    ]

    def self.check_request_error(response, auth:false)
      get_errors(auth: auth).each do |error_name, response_code, body|
        if response.code == response_code && response.body.include?(body)
          raise RequestError, error_name
        end
      end
      if response.code != 200
        raise RequestError, "GenericError"
      end
    end

    def self.get_errors(auth:false)
      auth ? AUTH_ERRORS : ERRORS
    end

    class RequestError < RuntimeError
    end

    class TokenError < RuntimeError
    end

    class CallbackError < RuntimeError
    end
  end
end
