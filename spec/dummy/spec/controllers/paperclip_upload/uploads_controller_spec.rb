require 'spec_helper'

describe PaperclipUpload::UploadsController, type: :controller do
  routes { PaperclipUpload::Engine.routes }

  describe "GET 'show'" do
    let!(:upload) { create(:upload) }

    it "returns 200 with existent id" do
      get :show, id: upload.id, format: :json
      expect(response).to be_success
      expect(json_response.upload.id).to eq(upload.id)
    end
  end

  describe "POST 'create'" do
    context "sending file attachment" do
      let(:file) { fixture_file_upload(Rails.root.join('spec', 'assets', 'bukowski.jpg')) }

      it "returns 201" do
        post :create, file: file, format: :json
        expect(response).to be_success
        expect(json_response.upload.id).not_to be_nil
      end
    end
  end
end
