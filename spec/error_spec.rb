require 'spec_helper'

describe AppleDEPClient::Error do
  describe AppleDEPClient::Error::RequestError do
    subject { AppleDEPClient::Error::RequestError }
    let(:body) { 'asdf' }
    it "takes a body" do
      expect { raise subject.new(body) }.to raise_error RuntimeError
    end
  end
  describe AppleDEPClient::Error::Auth do
    describe AppleDEPClient::Error::Auth::BadRequest do
      subject { AppleDEPClient::Error::Auth::BadRequest }
      specify { expect(subject).to be }
    end
    describe AppleDEPClient::Error::Auth::Unauthorized do
      subject { AppleDEPClient::Error::Auth::Unauthorized }
      specify { expect(subject).to be }
    end
    describe AppleDEPClient::Error::Auth::Forbidden do
      subject { AppleDEPClient::Error::Auth::Forbidden }
      specify { expect(subject).to be }
    end
  end
  describe AppleDEPClient::Error::MalformedRequest do
    subject { AppleDEPClient::Error::MalformedRequest }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::Unauthorized do
    subject { AppleDEPClient::Error::Unauthorized }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::Forbidden do
    subject { AppleDEPClient::Error::Forbidden }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::MethodNotAllowed do
    subject { AppleDEPClient::Error::MethodNotAllowed }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::InvalidCursor do
    subject { AppleDEPClient::Error::InvalidCursor }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::ExhaustedCursor do
    subject { AppleDEPClient::Error::ExhaustedCursor }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::CursorRequired do
    subject { AppleDEPClient::Error::CursorRequired }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::ExpiredCursor do
    subject { AppleDEPClient::Error::ExpiredCursor }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::NotFound do
    subject { AppleDEPClient::Error::NotFound }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::DeviceIDRequired do
    subject { AppleDEPClient::Error::DeviceIDRequired }
    specify { expect(subject).to be }
  end
end
