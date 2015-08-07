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

    it "has upload accessor" do
      expect(promotion).to respond_to(:upload)
    end

    it "has upload_identifier accessor" do
      expect(promotion).to respond_to(:upload_identifier)
    end

    context "with use_prefix option enabled" do
      it "has upload accessors" do
        expect(promotion).to respond_to(:prefixed_file_upload)
      end

      it "has upload_identifier accessor" do
        expect(promotion).to respond_to(:prefixed_file_upload_identifier)
      end

      it "raises error trying to redefine upload_accessor" do
        expect { Promotion.has_attached_upload(:photo) }.to raise_error(
          "you are trying to redefine upload_identifier attribute")
        expect { Promotion.has_attached_upload(:prefixed_file, upload: { use_prefix: true }) }.to raise_error(
          "you are trying to redefine prefixed_file_upload_identifier attribute")
      end
    end

    context "saving promotion" do
      context "with invalid upload" do
        it "raises error passing an invalid upload_identifier" do
          promotion.upload_identifier = "invalid upload identifier"
          expect { promotion.save }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "raises error passing an invalid upload" do
          promotion.upload = "invalid upload"
          expect { promotion.save }.to raise_error("invalid PaperclipUpload::Upload instance")
        end
      end

      context "with valid upload" do
        let!(:upload) { create(:upload) }

        def saves_with_upload(_paperclip_attr)
          expect(promotion.photo.exists?).to be_falsy
          yield(promotion)
          expect(promotion.save).to be_truthy
          expect(promotion.send(_paperclip_attr).exists?).to be_truthy
          expect { PaperclipUpload::Upload.find(upload.id) }.to(
            raise_error(ActiveRecord::RecordNotFound))
        end

        it "saves photo using upload instance" do
          saves_with_upload(:photo) { promotion.upload = upload }
        end

        it "saves photo using upload_identifier" do
          saves_with_upload(:photo) { promotion.upload_identifier = upload.identifier }
        end

        context "with use_prefix option enabled" do
          it "saves prefixed_file using upload_identifier" do
            saves_with_upload(:prefixed_file) do
              promotion.prefixed_file_upload_identifier = upload.identifier
            end
          end

          it "saves prefixed_file using upload instance" do
            saves_with_upload(:prefixed_file) { promotion.prefixed_file_upload = upload }
          end
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
