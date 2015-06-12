class PaperclipUpload::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_engine_migrations
    rake "railties:install:migrations"
  end
end
