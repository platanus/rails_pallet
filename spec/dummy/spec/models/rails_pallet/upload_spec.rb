require 'rails_helper'

RSpec.describe RailsPallet::Upload, type: :model do
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
      expect(RailsPallet::Upload.hashid.decode(upload.identifier).first).to eq(upload.id)
    end

    it "raises error with blank id" do
      expect { RailsPallet::Upload.new.identifier }.to(
        raise_error("valid with saved instance only"))
    end
  end

  describe "#file_extension" do
    it "returns nil with undefined file" do
      expect(RailsPallet::Upload.new.file_extension).to be_nil
    end

    it "returns valid extension" do
      expect(upload.file_extension).to eq('jpg')
    end
  end

  describe "#file_name" do
    it "returns nil with undefined file" do
      expect(RailsPallet::Upload.new.file_name).to be_nil
    end

    it "returns file name without extension" do
      expect(upload.file_name).to eq("bukowski")
    end
  end

  describe "#find_by_identifier" do
    it "raises error when identifier does not match any upload object" do
      expect { RailsPallet::Upload.find_by_identifier('xxx') }.to(
        raise_error(ActiveRecord::RecordNotFound))
    end

    it "returns upload object when identifier matches an upload object" do
      expect(RailsPallet::Upload.find_by_identifier(upload.identifier).id).to eq(upload.id)
    end
  end
end
