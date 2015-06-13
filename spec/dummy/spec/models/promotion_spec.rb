require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:promotion) { create(:promotion) }

  it "has has_attached_upload method" do
    expect(Promotion).to respond_to(:has_attached_upload)
  end

  it "wraps has_attached_file paperclip method" do
    expect(Promotion.new.photo).to be_a(Paperclip::Attachment)
  end

  it "has upload accessors" do
    promotion.upload = "upload"
    expect(promotion.upload).to eq("upload")
  end

  it "has upload_id accessor" do
    promotion.upload_id = "upload_id"
    expect(promotion.upload_id).to eq("upload_id")
  end

  context "saving promotion" do
    context "with invalid upload" do
      it "raise error passing an invalid upload_id" do
        promotion.upload_id = "invalid upload id"
        expect { promotion.save }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "raise error passing an invalid upload" do
        promotion.upload = "invalid upload"
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
        saves_with_upload { |promo| promotion.upload = upload }
      end

      it "saves photo using upload_id" do
        saves_with_upload { |promo| promotion.upload_id = upload.id }
      end
    end
  end
end
