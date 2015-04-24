require 'spec_helper'

describe AppleDEPClient::Request do
  describe ".make_request" do
    it "can make a request and return the body" do

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
end
