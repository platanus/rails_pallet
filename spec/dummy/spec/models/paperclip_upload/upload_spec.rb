require 'rails_helper'

RSpec.describe PaperclipUpload::Upload, type: :model do
  let(:upload) { build(:upload) }

  it "has a valid factory" do
    expect(upload).to be_valid
  end

  describe "validations" do
    it { should have_attached_file(:file) }
    it { should validate_attachment_presence(:file) }
  end
end
