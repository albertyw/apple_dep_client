require "spec_helper"

describe AppleDEPClient::Auth do
  before(:each) do
    Typhoeus::Expectation.clear
  end
  before(:all) do
    AppleDEPClient.configure do |x|
      x.consumer_key = "consumer_key"
      x.consumer_secret = "consumer_secret"
      x.access_token = "access_token"
      x.access_secret = "access_secret"
    end
  end
  describe ".get_session_token" do
    it "will make a successful request and return an X-ADM-Auth-Session token" do
      expect(AppleDEPClient::Auth).to receive(:oauth_header).once.and_call_original
      expect_any_instance_of(Typhoeus::Request).to receive(:run)
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200)
      Typhoeus.stub("/apple/")
      expect_any_instance_of(Typhoeus::Request).to receive(:response).and_return(response)
      expect(AppleDEPClient::Error).to receive(:check_request_error).with(response, auth: true)
      expect(AppleDEPClient::Auth).to receive(:parse_response).with(response).and_return("asdf").once
      expect(AppleDEPClient::Auth.get_session_token).to eq "asdf"
    end
  end
  describe ".parse_response" do
    let(:response) { Typhoeus::Response.new(return_code: :ok, response_code: 200, body: "{\"auth_session_token\":\"1234\"}") }
    it "will parse out the auth_session_token" do
      expect(AppleDEPClient::Auth.parse_response response).to eq "1234"
    end
  end
end
