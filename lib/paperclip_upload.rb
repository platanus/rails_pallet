require "paperclip"
require "responders"
require 'hashids'
require "active_model_serializers"
require "paperclip_upload/active_record_extension"
require "paperclip_upload/engine"

module PaperclipUpload
  extend self

  attr_writer :hash_salt, :use_prefix

  def hash_salt
    return "default" unless @hash_salt
    @hash_salt
  end

  def use_prefix
    @use_prefix == true
  end

  def setup
    yield self
    require "paperclip_upload"
  end
end
