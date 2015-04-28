require 'spec_helper'

describe AppleDEPClient::Device do
  describe ".fetch" do
    it "will iterate through data to yield devices" do
      response = {'cursor' => 'asdf', 'devices' => ['qwer', 'zxcv'], 'more_to_follow' => 'false'}
      expect(AppleDEPClient::Device).to receive(:make_request).with(nil).and_return(response).once
      devices = []
      AppleDEPClient::Device.fetch{|x| devices << x }
      expect(devices).to eq ['qwer', 'zxcv']
    end
    it "will iterate through multiple responses" do
      response = {'cursor' => '1', 'devices' => ['qwer'], 'more_to_follow' => 'true'}
      expect(AppleDEPClient::Device).to receive(:make_request).with(nil).and_return(response).once
      response = {'cursor' => '2', 'devices' => ['zxcv'], 'more_to_follow' => 'false'}
      expect(AppleDEPClient::Device).to receive(:make_request).with('1').and_return(response).once
      devices = []
      AppleDEPClient::Device.fetch{|x| devices << x }
      expect(devices).to eq ['qwer', 'zxcv']
    end
  end

  describe ".make_request" do
    it "will make a request" do
      expect(AppleDEPClient::Device).to receive(:fetch_body).with('cursor').and_return 'body'
      expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Device::FETCH_URL, :post, 'body').and_return('response').once
      expect(AppleDEPClient::Device.make_request 'cursor').to eq 'response'
    end
  end

  describe ".fetch_body" do
    it "will create a body to send" do
      body = {'limit' => AppleDEPClient::Device::FETCH_LIMIT, 'cursor' => 'asdf'}
      expect(JSON.parse(AppleDEPClient::Device.fetch_body 'asdf')).to eq body
    end
    it "won't sent a cursor if it's not specified" do
      body = {'limit' => AppleDEPClient::Device::FETCH_LIMIT}
      expect(JSON.parse(AppleDEPClient::Device.fetch_body nil)).to eq body
    end
  end

  describe ".disown" do
    it "will make a request to disown devices" do
      devices = ['asdf']
      expect(AppleDEPClient::Request).to receive(:make_request).and_return({"devices" => {"asdf"=>"SUCCESS"}})
      devices = AppleDEPClient::Device.disown devices
      expect(devices).to eq({"asdf" => "SUCCESS"})
    end
  end
end
