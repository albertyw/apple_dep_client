# Errors for AppleDEPClient and Apple's endpoints

module AppleDEPClient
  module Error

    AUTH_ERRORS = [
      # Used by AppleDEPClient::Auth
      ["BadRequest",          lambda{|response| response.code == 400 }],
      ["Unauthorized",        lambda{|response| response.code == 401 }],
      ["Forbidden",           lambda{|response| response.code == 403 }],

      # Catch-all error class
      ["GenericError",        lambda{|response| response.code != 200 }],
    ]

    ERRORS = [
      # Used by AppleDEPClient::Request
      ["MalformedRequest",    lambda{|response| response.code == 400 and response.body.strip == 'MALFORMED_REQUEST_BODY'}],
      ["Unauthorized",        lambda{|response| response.code == 401 and response.body.strip == 'UNAUTHORIZED' }],
      ["Forbidden",           lambda{|response| response.code == 403 and response.body.strip == 'FORBIDDEN' }],
      ["MethodNotAllowed",    lambda{|response| response.code == 405 }],

      # Used by AppleDEPClient::Device
      ["InvalidCursor",       lambda{|response| response.code == 400 and response.body.strip == 'INVALID_CURSOR' }],
      ["ExhaustedCursor",     lambda{|response| response.code == 400 and response.body.strip == 'EXHAUSTED_CURSOR' }],
      ["CursorRequired",      lambda{|response| response.code == 400 and response.body.strip == 'CURSOR_REQUIRED' }],
      ["ExpiredCursor",       lambda{|response| response.code == 400 and response.body.strip == 'EXPIRED_CURSOR' }],
      ["NotFound",            lambda{|response| response.code == 200 and response.body.strip == 'NOT_FOUND' }],
      ["DeviceIDRequired",    lambda{|response| response.code == 400 and response.body.strip == 'DEVICE_ID_REQUIRED' }],

      # Used by AppleDEPClient::Profile
      ["ConfigUrlRequired",   lambda{|response| response.code == 400 and response.body.strip == 'CONFIG_URL_REQUIRED' }],
      ["ConfigNameRequired",  lambda{|response| response.code == 400 and response.body.strip == 'CONFIG_NAME_REQUIRED' }],
      ["FlagsInvalid",        lambda{|response| response.code == 400 and response.body.strip == 'FLAGS_INVALID' }],
      ["ConfigUrlInvalid",    lambda{|response| response.code == 400 and response.body.strip == 'CONFIG_URL_INVALID' }],
      ["ConfigNameInvalid",   lambda{|response| response.code == 400 and response.body.strip == 'CONFIG_NAME_INVALID' }],
      ["DepartmentInvalid",   lambda{|response| response.code == 400 and response.body.strip == 'DEPARTMENT_INVALID' }],
      ["SupportPhoneInvalid", lambda{|response| response.code == 400 and response.body.strip == 'SUPPORT_PHONE_INVALID' }],
      ["SupportEmailInvalid", lambda{|response| response.code == 400 and response.body.strip == 'SUPPORT_EMAIL_INVALID' }],
      ["DescriptionInvalid",  lambda{|response| response.code == 400 and response.body.strip == 'DESCRIPTION_INVALID' }],
      ["MagicInvalid",        lambda{|response| response.code == 400 and response.body.strip == 'MAGIC_INVALID' }],
      ["ProfileUUIDRequired", lambda{|response| response.code == 400 and response.body.strip == 'PROFILE_UUID_REQUIRED' }],
      ["ProfileNotFound",     lambda{|response| response.code == 400 and response.body.strip == 'PROFILE_NOT_FOUND' }],

      # Catch-all error class
      ["GenericError",        lambda{|response| response.code != 200 }],
    ]

    def self.check_request_error(response, auth=false)
      get_errors(auth).each do |error_name, error_check|
        if error_check.call(response)
          raise RequestError, error_name
        end
      end
    end

    def self.get_errors(auth=false)
      auth ? AUTH_ERRORS : ERRORS
    end

    class RequestError < RuntimeError
    end

  end
end
