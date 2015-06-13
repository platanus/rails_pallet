FactoryGirl.define do
  factory :promotion do
    photo nil

    factory :promotion_with_photo do
      photo { fixture_file_upload(Rails.root.join('spec', 'assets', 'bukowski.jpg'), 'image/png') }
    end
  end
end
