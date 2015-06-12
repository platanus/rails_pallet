include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :upload, :class => 'PaperclipUpload::Upload' do
    file { fixture_file_upload(Rails.root.join('spec', 'assets', 'bukowski.jpg'), 'image/png') }
  end
end
