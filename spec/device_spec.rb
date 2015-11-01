require "spec_helper"

describe AppleDEPClient::Device do
  describe ".fetch" do
    before do
      @url = AppleDEPClient::Device::FETCH_PATH
    end
    it "will iterate through data to yield devices" do
      response = { "cursor" => "asdf", "devices" => ["qwer", "zxcv"], "more_to_follow" => "false" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with(nil, @url).and_return(response).once
      devices = []
      AppleDEPClient::Device.fetch { |x| devices << x }
      expect(devices).to eq ["qwer", "zxcv"]
    end
    it "will iterate through multiple responses" do
      response = { "cursor" => "1", "devices" => ["qwer"], "more_to_follow" => "true" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with(nil, @url).and_return(response).once
      response = { "cursor" => "2", "devices" => ["zxcv"], "more_to_follow" => "false" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with("1", @url).and_return(response).once
      devices = []
      AppleDEPClient::Device.fetch { |x| devices << x }
      expect(devices).to eq ["qwer", "zxcv"]
    end
    it "will return the last cursor" do
      response = { "cursor" => "1", "devices" => ["qwer"], "more_to_follow" => "true" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with(nil, @url).and_return(response).once
      response = { "cursor" => "2", "devices" => ["zxcv"], "more_to_follow" => "false" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with("1", @url).and_return(response).once
      cursor = AppleDEPClient::Device.fetch {}
      expect(cursor).to eq "2"
    end
  end

  describe ".make_fetch_request" do
    it "will make a request" do
      expect(AppleDEPClient::Device).to receive(:fetch_body).with("cursor").and_return "body"
      url = AppleDEPClient::Request.make_url(AppleDEPClient::Device::FETCH_PATH)
      expect(AppleDEPClient::Request).to receive(:make_request).with(url, :post, "body").and_return("response").once
      expect(AppleDEPClient::Device.make_fetch_request "cursor", AppleDEPClient::Device::FETCH_PATH).to eq "response"
    end
  end

  describe ".fetch_body" do
    it "will create a body to send" do
      body = { "limit" => AppleDEPClient::Device::FETCH_LIMIT, "cursor" => "asdf" }
      expect(JSON.parse(AppleDEPClient::Device.fetch_body "asdf")).to eq body
    end
    it "won't sent a cursor if it's not specified" do
      body = { "limit" => AppleDEPClient::Device::FETCH_LIMIT }
      expect(JSON.parse(AppleDEPClient::Device.fetch_body nil)).to eq body
    end
  end

  describe ".sync" do
    before do
      @url = AppleDEPClient::Device::SYNC_PATH
    end
    it "will use a cursor and return results" do
      response = { "cursor" => "2", "devices" => ["zxcv"], "more_to_follow" => "false" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with("1", @url).and_return(response).once
      devices = []
      AppleDEPClient::Device.sync("1") { |x| devices << x }
      expect(devices).to eq ["zxcv"]
    end
    it "will return a new cursor" do
      response = { "cursor" => "2", "devices" => ["zxcv"], "more_to_follow" => "false" }
      expect(AppleDEPClient::Device).to receive(:make_fetch_request).with("1", @url).and_return(response).once
      cursor = AppleDEPClient::Device.sync("1") {}
      expect(cursor).to eq "2"
    end
  end

  describe ".details" do
    it "will return details of devices" do
      devices = ["asdf"]
      expect(AppleDEPClient::Request).to receive(:make_request).and_return("devices" => { "asdf" => "data" })
      devices = AppleDEPClient::Device.details devices
      expect(devices).to eq("asdf" => "data")
    end
  end

  describe ".disown" do
    it "will make a request to disown devices" do
      devices = ["asdf"]
      expect(Kernel).to receive(:warn)
      expect(AppleDEPClient::Request).to receive(:make_request).and_return("devices" => { "asdf" => "SUCCESS" })
      devices = AppleDEPClient::Device.disown devices
      expect(devices).to eq("asdf" => "SUCCESS")
    end
  end
end
