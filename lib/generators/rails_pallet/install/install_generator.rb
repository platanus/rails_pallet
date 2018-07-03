require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

class RailsPallet::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

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

  def self.next_migration_number(path)
    ActiveRecord::Generators::Base.next_migration_number(path)
  end

  def copy_engine_migrations
    migration_template(
      'create_rails_pallet_uploads.rb.erb',
      'db/migrate/create_rails_pallet_uploads.rb'
    )

    migration_template(
      'add_attachment_file_to_uploads.rb.erb',
      'db/migrate/add_attachment_file_to_uploads.rb'
    )
  end
end
