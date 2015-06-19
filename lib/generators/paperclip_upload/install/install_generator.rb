class PaperclipUpload::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_initializer
    template "initializer.rb", "config/initializers/paperclip_upload.rb"
  end

  def mount_routes
    line = "Rails.application.routes.draw do"
    gsub_file "config/routes.rb", /(#{Regexp.escape(line)})/mi do |match|
      <<-HERE.gsub(/^ {9}/, '')
         #{match}
           mount PaperclipUpload::Engine => '/'
           PaperclipUpload.draw_additional_upload_endpoints(self)
         HERE
    end
  end

  def copy_engine_migrations
    rake "railties:install:migrations"
  end
end
