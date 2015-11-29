class RailsPallet::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_initializer
    template "initializer.rb", "config/initializers/rails_pallet.rb"
  end

  def mount_routes
    line = "Rails.application.routes.draw do"
    gsub_file "config/routes.rb", /(#{Regexp.escape(line)})/mi do |match|
      <<-HERE.gsub(/^ {9}/, '')
         #{match}
           mount RailsPallet::Engine => '/'
         HERE
    end
  end

  def copy_engine_migrations
    rake "railties:install:migrations"
  end
end
