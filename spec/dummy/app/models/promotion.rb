# == Schema Information
#
# Table name: promotions
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Promotion < ActiveRecord::Base
  has_attached_upload :photo, path: ':rails_root/public/promotions/:id/:filename'
  allow_encoded_file_for :photo
  do_not_validate_attachment_file_type :photo

  has_attached_upload :prefixed_file,
    path: ':rails_root/public/promotions/:id/:filename', upload: { use_prefix: true }
  do_not_validate_attachment_file_type :prefixed_file
end
