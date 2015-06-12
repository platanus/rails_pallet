class PaperclipUpload::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def mount_routes
    line = "Rails.application.routes.draw do"
    gsub_file "config/routes.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n  mount PaperclipUpload::Engine => '/'\n"
    end
  end

  def copy_engine_migrations
    rake "railties:install:migrations"
  end
end
