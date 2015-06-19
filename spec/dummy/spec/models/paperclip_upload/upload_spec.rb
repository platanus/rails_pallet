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

  describe "#id_to_hash" do
    it "returns hash" do
      hashids = Hashids.new(PaperclipUpload.hash_salt)
      hash = upload.id_to_hash
      expect(hashids.decode(hash).first).to eq(upload.id)
    end

    it "raises error with blank id" do
      expect { PaperclipUpload::Upload.new.id_to_hash }.to(
        raise_error("valid with saved instance only"))
    end
  end
end
