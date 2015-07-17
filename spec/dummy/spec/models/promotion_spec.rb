require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:promotion) { create(:promotion) }

  describe "#has_attached_upload" do
    it "has has_attached_upload method" do
      expect(Promotion).to respond_to(:has_attached_upload)
    end

    it "wraps has_attached_file paperclip method" do
      expect(Promotion.new.photo).to be_a(Paperclip::Attachment)
    end

    it "has upload accessors" do
      promotion.photo_upload = "upload"
      expect(promotion.photo_upload).to eq("upload")
    end

    it "has photo_upload_identifier accessor" do
      promotion.photo_upload_identifier = "photo_upload_identifier"
      expect(promotion.photo_upload_identifier).to eq("photo_upload_identifier")
    end

    context "saving promotion" do
      context "with invalid upload" do
        it "raise error passing an invalid photo_upload_identifier" do
          promotion.photo_upload_identifier = "invalid upload identifier"
          expect { promotion.save }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "raise error passing an invalid upload" do
          promotion.photo_upload = "invalid upload"
          expect { promotion.save }.to raise_error("invalid PaperclipUpload::Upload instance")
        end
      end

      context "with valid upload" do
        let(:upload) { create(:upload) }

        def saves_with_upload
          expect(promotion.photo.exists?).to be_falsy
          yield(promotion)
          expect(promotion.save).to be_truthy
          expect(promotion.photo.exists?).to be_truthy
          expect { PaperclipUpload::Upload.find(upload.id) }.to(
            raise_error(ActiveRecord::RecordNotFound))
        end

        it "saves photo using upload instance" do
          saves_with_upload { |promo| promotion.photo_upload = upload }
        end

        it "saves photo using photo_upload_identifier" do
          saves_with_upload { |promo| promotion.photo_upload_identifier = upload.identifier }
        end
      end
    end
  end

  describe "#allow_encoded_file_for" do
    it "has allow_encoded_file_for method" do
      expect(Promotion).to respond_to(:allow_encoded_file_for)
    end

    it "has encoded_photo accessor" do
      promotion.encoded_photo = "encoded_photo"
      expect(promotion.encoded_photo).to eq("encoded_photo")
    end

    context "saving promotion" do
      context "with encoded photo" do
        let(:encoded_promotion) { build(:promotion_with_encoded_photo) }

        it "decodes and save photo" do
          expect(encoded_promotion.photo.exists?).to be_falsy
          expect(encoded_promotion.save).to be_truthy
          expect(encoded_promotion.photo.exists?).to be_truthy
        end
      end
    end
  end
end
