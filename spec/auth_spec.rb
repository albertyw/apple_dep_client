require 'spec_helper'

describe AppleDEPClient::Auth do
  before(:each) do
    Typhoeus::Expectation.clear
  end
  before(:all) do
    AppleDEPClient.configure do |x|
      x.consumer_key = 'consumer_key'
      x.consumer_secret = 'consumer_secret'
      x.access_token = 'access_token'
      x.access_secret = 'access_secret'
    end
  end
  describe ".get_session_token" do
    it "will make a successful request and return an X-ADM-Auth-Session token" do
      expect(AppleDEPClient::Auth).to receive(:oauth_header).once.and_call_original
      expect_any_instance_of(Typhoeus::Request).to receive(:run)
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200)
      Typhoeus.stub('/apple/')
      expect_any_instance_of(Typhoeus::Request).to receive(:response).and_return(response)
      expect(AppleDEPClient::Auth).to receive(:parse_response).with(response).and_return('asdf').once
      expect(AppleDEPClient::Auth).to_not receive(:parse_error)
      expect(AppleDEPClient::Auth.get_session_token).to eq 'asdf'
    end
    it "will make an unsuccessful request and parse error" do
      expect(AppleDEPClient::Auth).to receive(:oauth_header).once.and_call_original
      expect_any_instance_of(Typhoeus::Request).to receive(:run)
      response = Typhoeus::Response.new(return_code: :bad_request, response_code: 400)
      Typhoeus.stub('/apple/')
      expect_any_instance_of(Typhoeus::Request).to receive(:response).and_return(response)
      expect(AppleDEPClient::Auth).to_not receive(:parse_response)
      expect(AppleDEPClient::Auth).to receive(:parse_error).with(response).once
      AppleDEPClient::Auth.get_session_token
    end
  end
  describe ".parse_response" do
    let(:response) { Typhoeus::Response.new(return_code: :ok, response_code: 200, body: "{\"auth_session_token\":\"1234\"}") }
    it "will parse out the auth_session_token" do
      expect(AppleDEPClient::Auth.parse_response response).to eq '1234'
    end
  end
  describe ".parse_error" do
    it "can raise AuthBadRequest" do
      response = Typhoeus::Response.new(return_code: :bad_request, response_code: 400)
      expect{AppleDEPClient::Auth.parse_error response}.to raise_error AppleDEPClient::Error::AuthBadRequest
    end
    it "can raise AuthUnauthorized" do
      response = Typhoeus::Response.new(return_code: :unauthorized, response_code: 401)
      expect{AppleDEPClient::Auth.parse_error response}.to raise_error AppleDEPClient::Error::AuthUnauthorized
    end
    it "can raise AuthForbidden" do
      response = Typhoeus::Response.new(return_code: :forbidden, response_code: 403)
      expect{AppleDEPClient::Auth.parse_error response}.to raise_error AppleDEPClient::Error::AuthForbidden
    end
    it "can raise RequestError" do
      response = Typhoeus::Response.new(return_code: :server_error, response_code: 500)
      expect{AppleDEPClient::Auth.parse_error response}.to raise_error AppleDEPClient::Error::RequestError
    end
  end
end
