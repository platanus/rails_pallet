FactoryGirl.define do
  factory :promotion do
    photo nil

    factory :promotion_with_photo do
      photo { fixture_file_upload(Rails.root.join('spec', 'assets', 'bukowski.jpg')) }
    end

    factory :promotion_with_encoded_photo do
      encoded_photo { Base64.encode64(File.open(Rails.root.join('spec', 'assets', 'bukowski.jpg')).read) }
    end
  end
end
