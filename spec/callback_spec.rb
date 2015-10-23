require "spec_helper"

describe AppleDEPClient::Callback do
  describe ".decode_callback" do
    it "will call decrypt_data and feed data to parse_data" do
      expect(AppleDEPClient::Callback).to receive(:decrypt_data).with("qwer").and_return("asdf").once
      expect(AppleDEPClient::Callback).to receive(:parse_data).with("asdf").and_return("zxcv").once
      AppleDEPClient::Callback.decode_callback "qwer"
    end
  end

  describe ".decrypt_data" do
    it "will decrypt data and remove encryption data" do
      expect(AppleDEPClient::Token).to receive(:create_temp_file).with("data", "asdf", binary: true).and_call_original
      expect(AppleDEPClient::Token).to receive(:run_command).and_return(["data", ""]).once
      expect(AppleDEPClient::Callback).to receive(:remove_encryption_data).with("data").once
      AppleDEPClient::Callback.decrypt_data "asdf"
    end
    it "will raise an error if the data cannot be decrypted" do
      expect(AppleDEPClient::Token).to receive(:create_temp_file).with("data", "asdf", binary: true).and_call_original
      expect(AppleDEPClient::Token).to receive(:run_command).and_return(["", "error"]).once
      expect(AppleDEPClient::Callback).to_not receive(:remove_encryption_data)
      expect { AppleDEPClient::Callback.decrypt_data "asdf" }.to raise_error AppleDEPClient::Error::CallbackError
    end
  end

  describe ".remove_encryption_data" do
    it "will only return data between doctype and plist" do
      data = "asdfasdfasdf\n<!DOCTYPE>\ntext\ntext\n</plist>\nqwerqwerqwer"
      cleaned_data = AppleDEPClient::Callback.remove_encryption_data data
      expect(cleaned_data).to eq "<!DOCTYPE>\ntext\ntext\n</plist>"
    end
  end

  describe ".parse_data" do
    it "will return the parsed plist" do
      data = "<plist><dict></dict></plist>"
      data = AppleDEPClient::Callback.parse_data data
      expect(data).to eq({})
    end
  end
end
