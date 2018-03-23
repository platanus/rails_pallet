FactoryBot.define do
  factory :promotion do
    photo nil

    factory :promotion_with_photo do
      photo { fixture_file_upload(Rails.root.join('spec', 'assets', 'bukowski.jpg')) }
    end

    factory :promotion_with_encoded_photo do
      encoded_photo do
        header = "data:image/png;base64,"
        file = Rails.root.join('spec', 'assets', 'bukowski.jpg')
        header + Base64.encode64(File.open(file).read)
      end
    end
  end
end
