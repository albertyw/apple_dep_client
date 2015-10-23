require "spec_helper"

describe "AppleDEPClient::Configuration" do
  it "has a default apple_dep_server value" do
    expect(AppleDEPClient::Configuration::DEP_CONFIG[:apple_dep_server]).to_not be_nil
  end

  it "can be configured" do
    AppleDEPClient.private_key = "asdf"
    AppleDEPClient.consumer_key = "qwer"
    expect(AppleDEPClient.private_key).to eq "asdf"
    expect(AppleDEPClient.consumer_key).to eq "qwer"
  end

  describe ".method_missing" do
    it "can get value for valid configuration keys" do
      expect(AppleDEPClient).to receive(:get_value).with(:access_token).and_return "asdf"
      expect(AppleDEPClient.access_token).to eq "asdf"
    end
    it "can raise NoMethodError for invalid configuration keys" do
      expect { AppleDEPClient.asdf }.to raise_error NoMethodError
    end
  end

  describe ".get_value" do
    it "can get a configuration value directly from the saved value" do
      AppleDEPClient.private_key = "qwer"
      expect(AppleDEPClient.private_key).to eq "qwer"
    end
    it "will get the default value if the instance variable isn't set" do
      expect(AppleDEPClient.apple_dep_server).to_not be_nil
    end
    it "can get a configuration value by calling a Proc" do
      AppleDEPClient.private_key = lambda { return "qwer" }
      expect(AppleDEPClient.private_key).to eq "qwer"
    end
  end

  describe ".get_default_value" do
    it "will read the default value from DEP_CONFIG" do
      apple_dep_server = AppleDEPClient::Configuration::DEP_CONFIG[:apple_dep_server]
      expect(AppleDEPClient.get_default_value("apple_dep_server")).to eq apple_dep_server
    end
  end

  describe ".configure" do
    it "can be configured in a block" do
      AppleDEPClient.configure do |x|
        x.private_key = "asdf"
      end
      expect(AppleDEPClient.private_key).to eq "asdf"
    end
  end
end
