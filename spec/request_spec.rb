require 'spec_helper'

describe AppleDEPClient::Request do
  before(:each) do
    Typhoeus::Expectation.clear
  end
  describe ".make_request" do
    it "can make a request and return the body" do
      expect(AppleDEPClient::Request).to receive(:make_headers).once
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200, body: '[]')
      Typhoeus.stub('url').and_return response
      expect(AppleDEPClient::Request).to receive(:check_response).with(response).once
      body = AppleDEPClient::Request.make_request('url', 'get', 'asdf')
      expect(body).to eq []
    end
    it "can override default headers" do
      expect(AppleDEPClient::Request).to_not receive(:make_headers)
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200, body: '{"qwer": 2}')
      Typhoeus.stub('url').and_return response
      expect(AppleDEPClient::Request).to receive(:check_response).with(response).once
      body = AppleDEPClient::Request.make_request('url', 'get', 'asdf', {})
      expect(body).to eq({"qwer" => 2})
    end
  end
  describe ".make_headers" do
    it "will make a hash of headers" do
      expect(AppleDEPClient::Auth).to receive(:get_session_token).and_return('asdf').once
      headers = AppleDEPClient::Request.make_headers
      expect(headers.keys).to include 'User-Agent'
      expect(headers['X-Server-Protocol-Version']).to eq '2'
      expect(headers['X-ADM-Auth-Session']).to eq 'asdf'
      expect(headers['Content-Type']).to eq 'application/json;charset=UTF8'
    end
  end
  describe ".check_response" do
    it "will not raise an error if the response is ok" do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200)
      expect{AppleDEPClient::Request.check_response response}.to_not raise_error
    end
    it "can raise a MalformedRequest error" do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' MALFORMED_REQUEST_BODY ')
      expect{AppleDEPClient::Request.check_response response}.to raise_error AppleDEPClient::Error::MalformedRequest
    end
    it "can raise a Unauthorized error" do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 401, body: 'UNAUTHORIZED')
      expect{AppleDEPClient::Request.check_response response}.to raise_error AppleDEPClient::Error::Unauthorized
    end
    it "can raise a Forbidden error" do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 403, body: 'FORBIDDEN')
      expect{AppleDEPClient::Request.check_response response}.to raise_error AppleDEPClient::Error::Forbidden
    end
    it "can raise a MethodNotAllowed error" do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 405)
      expect{AppleDEPClient::Request.check_response response}.to raise_error AppleDEPClient::Error::MethodNotAllowed
    end
    it "can raise an error" do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 500)
      expect{AppleDEPClient::Request.check_response response}.to raise_error AppleDEPClient::Error::GenericError
    end
  end
end
