require "spec_helper"

describe AppleDEPClient::Request do
  before(:each) do
    Typhoeus::Expectation.clear
  end
  describe ".make_request" do
    it "can make a request and return the body" do
      expect(AppleDEPClient::Request).to receive(:make_headers).once
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200, body: "[]")
      Typhoeus.stub("url").and_return response
      expect(AppleDEPClient::Error).to receive(:check_request_error).with(response).once
      body = AppleDEPClient::Request.make_request("url", "get", "asdf")
      expect(body).to eq []
    end
    it "can override default headers" do
      expect(AppleDEPClient::Request).to_not receive(:make_headers)
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200, body: '{"qwer": 2}')
      Typhoeus.stub("url").and_return response
      expect(AppleDEPClient::Error).to receive(:check_request_error).with(response).once
      body = AppleDEPClient::Request.make_request("url", "get", "asdf", headers: {})
      expect(body).to eq("qwer" => 2)
    end
    it "can add params to the url" do
      expect(AppleDEPClient::Request).to receive(:make_headers)
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200, body: '{"qwer": 2}')
      Typhoeus.stub("url").and_return response
      body = AppleDEPClient::Request.make_request("url", "get", "asdf", params: { "a" => "b" })
      expect(body).to eq("qwer" => 2)
    end
  end
  describe ".make_headers" do
    it "will make a hash of headers" do
      expect(AppleDEPClient::Auth).to receive(:get_session_token).and_return("asdf").once
      headers = AppleDEPClient::Request.make_headers
      expect(headers["User-Agent"]).to include AppleDEPClient.user_agent
      expect(headers["X-Server-Protocol-Version"]).to eq "2"
      expect(headers["X-ADM-Auth-Session"]).to eq "asdf"
      expect(headers["Content-Type"]).to eq "application/json;charset=UTF8"
    end
  end

  describe ".make_url" do
    it "will make a url from the config and a path" do
      AppleDEPClient.apple_dep_server = "qwer"
      expect(AppleDEPClient::Request.make_url("asdf")).to eq "qwerasdf"
    end
  end
end
