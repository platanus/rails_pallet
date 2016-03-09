require 'spec_helper'

RSpec.describe RailsPallet::UploadsController, type: :controller do
  routes { RailsPallet::Engine.routes }

  describe "POST 'create'" do
    context "sending file attachment" do
      let(:file) { fixture_file_upload(Rails.root.join('spec', 'assets', 'bukowski.jpg')) }

      it "returns 201" do
        post :create, file: file, format: :json
        expect(response).to be_success
        expect(json_response.upload.identifier).not_to be_nil
        expect(json_response.upload.file_name).to eq('bukowski')
        expect(json_response.upload.file_extension).to eq('jpg')
      end
    end
  end
end
