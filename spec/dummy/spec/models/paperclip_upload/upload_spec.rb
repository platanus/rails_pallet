require 'rails_helper'

RSpec.describe PaperclipUpload::Upload, type: :model do
  let(:upload) { create(:upload) }

  it "has a valid factory" do
    expect(upload).to be_valid
  end

  describe "validations" do
    it { should have_attached_file(:file) }
    it { should validate_attachment_presence(:file) }
  end

  describe "#identifier" do
    it "returns hash" do
      expect(PaperclipUpload::Upload.hashid.decode(upload.identifier).first).to eq(upload.id)
    end

    it "raises error with blank id" do
      expect { PaperclipUpload::Upload.new.identifier }.to(
        raise_error("valid with saved instance only"))
    end
  end
end
