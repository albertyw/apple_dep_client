require 'spec_helper'

describe AppleDEPClient::Error do
  describe AppleDEPClient::Error::AbstractRequestError do
    subject { AppleDEPClient::Error::AbstractRequestError }
    let(:body) { 'asdf' }
    it "takes a body" do
      expect { raise subject.new(body) }.to raise_error RuntimeError
    end
  end
  describe AppleDEPClient::Error::Auth do
    describe AppleDEPClient::Error::Auth::BadRequest do
      subject { AppleDEPClient::Error::Auth::BadRequest }
      specify { expect(subject).to be }
      it 'can return true for check response' do
        response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: '')
        expect(subject.check_response response).to be_truthy
      end
    end
    describe AppleDEPClient::Error::Auth::Unauthorized do
      subject { AppleDEPClient::Error::Auth::Unauthorized }
      specify { expect(subject).to be }
      it 'can return true for check response' do
        response = Typhoeus::Response.new(return_code: :ok, response_code: 401, body: '')
        expect(subject.check_response response).to be_truthy
      end
    end
    describe AppleDEPClient::Error::Auth::Forbidden do
      subject { AppleDEPClient::Error::Auth::Forbidden }
      specify { expect(subject).to be }
      it 'can return true for check response' do
        response = Typhoeus::Response.new(return_code: :ok, response_code: 403)
        expect(subject.check_response response).to be_truthy
      end
    end
  end
  describe AppleDEPClient::Error::GenericError do
    subject { AppleDEPClient::Error::GenericError }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 500, body: '')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::MalformedRequest do
    subject { AppleDEPClient::Error::MalformedRequest }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' MALFORMED_REQUEST_BODY ')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::Unauthorized do
    subject { AppleDEPClient::Error::Unauthorized }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 401, body: 'UNAUTHORIZED')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::Forbidden do
    subject { AppleDEPClient::Error::Forbidden }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 403, body: 'FORBIDDEN')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::MethodNotAllowed do
    subject { AppleDEPClient::Error::MethodNotAllowed }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 405, body: '')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::InvalidCursor do
    subject { AppleDEPClient::Error::InvalidCursor }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' INVALID_CURSOR ')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::ExhaustedCursor do
    subject { AppleDEPClient::Error::ExhaustedCursor }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' EXHAUSTED_CURSOR ')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::CursorRequired do
    subject { AppleDEPClient::Error::CursorRequired }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' CURSOR_REQUIRED ')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::ExpiredCursor do
    subject { AppleDEPClient::Error::ExpiredCursor }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' EXPIRED_CURSOR ')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::NotFound do
    subject { AppleDEPClient::Error::NotFound }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 200, body: ' NOT_FOUND ')
      expect(subject.check_response response).to be_truthy
    end
  end
  describe AppleDEPClient::Error::DeviceIDRequired do
    subject { AppleDEPClient::Error::DeviceIDRequired }
    specify { expect(subject).to be }
    it 'can return true for check response' do
      response = Typhoeus::Response.new(return_code: :ok, response_code: 400, body: ' DEVICE_ID_REQUIRED ')
      expect(subject.check_response response).to be_truthy
    end
  end
end
