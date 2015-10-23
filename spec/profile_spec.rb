require "spec_helper"

describe AppleDEPClient::Profile do
  describe ".define" do
    it "sends a profile to apple" do
      data = { profile_name: "asdf" }
      url = AppleDEPClient::Request.make_url(AppleDEPClient::Profile::DEFINE_PATH)
      expect(AppleDEPClient::Request).to receive(:make_request).with(url, :post, '{"profile_name":"asdf"}').once
      AppleDEPClient::Profile.define data
    end
    it "doesn't send unrecognized data to apple" do
      data = { asdf: "asdf" }
      url = AppleDEPClient::Request.make_url(AppleDEPClient::Profile::DEFINE_PATH)
      expect(AppleDEPClient::Request).to receive(:make_request).with(url, :post, "{}").once
      AppleDEPClient::Profile.define data
    end
  end
  describe ".assign" do
    it "sends a request to assign a profile to data" do
      url = AppleDEPClient::Request.make_url(AppleDEPClient::Profile::ASSIGN_PATH)
      expect(AppleDEPClient::Request).to receive(:make_request).with(url, :put, anything).once
      AppleDEPClient::Profile.assign("1", "a")
    end
  end
  describe ".fetch" do
    it "sends a request to fetch a profile" do
      url = AppleDEPClient::Request.make_url(AppleDEPClient::Profile::FETCH_PATH)
      expect(AppleDEPClient::Request).to receive(:make_request).with(url, :get, nil, params: anything).once
      AppleDEPClient::Profile.fetch("1")
    end
  end
  describe ".remove" do
    it "sends a request to remove profiles from devices" do
      url = AppleDEPClient::Request.make_url(AppleDEPClient::Profile::REMOVE_PATH)
      expect(AppleDEPClient::Request).to receive(:make_request).with(url, :delete, anything).once
      AppleDEPClient::Profile.remove("a")
    end
  end
end
