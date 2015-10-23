require "spec_helper"

describe "AppleDEPClient::Token" do
  describe ".decode_token" do
    it "can receive and decrypt an AppleDEPClient Token" do
      expect(AppleDEPClient::Token).to receive(:parse_data).once
      expect(AppleDEPClient::Token).to receive(:create_temp_file).twice.and_call_original
      expect(AppleDEPClient::Token).to receive(:remove_temp_file).twice
      expect(AppleDEPClient::Token).to receive(:run_command).once.and_return ["{}", ""]
      AppleDEPClient::Token.decode_token("sample data")
    end
    it "will raise an error if the decryption returned no data" do
      expect(AppleDEPClient::Token).to_not receive(:parse_data)
      expect(AppleDEPClient::Token).to receive(:create_temp_file).twice.and_call_original
      expect(AppleDEPClient::Token).to receive(:remove_temp_file).twice
      expect(AppleDEPClient::Token).to receive(:run_command).once.and_return ["", "error"]
      expect { AppleDEPClient::Token.decode_token("sample data") }.to raise_error AppleDEPClient::Error::TokenError
    end
  end

  describe ".create_temp_file" do
    it "will not write a binary Tempfile by default" do
      expect_any_instance_of(Tempfile).to_not receive :binmode
      AppleDEPClient::Token.create_temp_file("asdf", "qwer")
    end
    it "can write a binary Tempfile" do
      expect_any_instance_of(Tempfile).to receive :binmode
      AppleDEPClient::Token.create_temp_file("asdf", "qwer", binary: true)
    end
  end

  describe ".run_command" do
    it "can run a command" do
      command = "ls"
      data, errors = AppleDEPClient::Token.run_command command
      expect(data).to_not be_empty
      expect(errors).to be_empty
    end
  end

  describe ".parse_data" do
    let(:data) { "-----BEGIN MESSAGE-----\n{\"consumer_key\": \"asdf\"}\n-----END MESSAGE-----" }
    it "can parse JSON data and return it" do
      expect(AppleDEPClient::Token.parse_data(data)).to eq ({ consumer_key: "asdf" })
    end
    it "will save JSON data" do
      expect(AppleDEPClient::Token).to receive(:save_data)
      AppleDEPClient::Token.parse_data(data)
    end
  end

  describe ".save_data" do
    let(:data) { { consumer_key: "asdf", access_token: "qwer" } }
    it "can save data" do
      AppleDEPClient::Token.save_data(data)
      expect(AppleDEPClient.consumer_key).to eq "asdf"
      expect(AppleDEPClient.access_token).to eq "qwer"
    end
    it "will not overwrite lambdas" do
      AppleDEPClient.consumer_key = lambda { "lambda" }
      AppleDEPClient::Token.save_data(data)
      expect(AppleDEPClient.consumer_key).to eq "lambda"
      expect(AppleDEPClient.access_token).to eq "qwer"
    end
  end
end
