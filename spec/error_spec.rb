require 'spec_helper'

describe AppleDEPClient::Error do
  describe ".check_request_error" do
    it "raises an error if a lambda returns true" do
      response = Typhoeus::Response.new(response_code: 400, body: '')
      expect{AppleDEPClient::Error.check_request_error response}.to raise_error AppleDEPClient::Error::RequestError
    end
    it "can also check for auth errors" do
      response = Typhoeus::Response.new(response_code: 500, body: '')
      expect{AppleDEPClient::Error.check_request_error(response, true)}.to raise_error AppleDEPClient::Error::RequestError
    end
  end
  describe ".get_errors" do
    it "can return normal errors" do
      errors = AppleDEPClient::Error.get_errors
      expect(errors.map{|error| error[0]}).to include 'MalformedRequest'
    end
    it "can return auth errors" do
      errors = AppleDEPClient::Error.get_errors true
      expect(errors.map{|error| error[0]}).to include 'BadRequest'
    end
  end
end
