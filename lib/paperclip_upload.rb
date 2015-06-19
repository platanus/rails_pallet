require "paperclip"
require "responders"
require 'hashids'
require "active_model_serializers"
require "paperclip_upload/active_record_extension"
require "paperclip_upload/engine"

module PaperclipUpload
  extend self

  attr_accessor :additional_upload_endpoints
  attr_writer :hash_salt

  def draw_additional_upload_endpoints(_ctx)
    return if !self.additional_upload_endpoints || additional_upload_endpoints.count.zero?
    self.additional_upload_endpoints.each do |endpoint|
      _ctx.post "#{endpoint}" => "paperclip_upload/uploads#create"
    end
  end

  def hash_salt
    return "default" unless @hash_salt
    @hash_salt
  end

  def setup
    yield self
    require "paperclip_upload"
  end
end
