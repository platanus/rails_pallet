class PaperclipUpload::UploadControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :base_controller, type: :string, :default => "application"

  def generate_controller
    generate "controller #{name}"
  end

  def replace_controller_with_template
    copy_file "controller.rb", "app/controllers/#{name}_controller.rb", force: true
  end

  def customize_controller
    line = "class UploadController < ApplicationController"
    gsub_file "app/controllers/#{name}_controller.rb", /(#{Regexp.escape(line)})/mi do |match|
      "class #{name.classify.pluralize}Controller < #{base_controller.classify}Controller"
    end

    link = "\"download_link\""
    gsub_file "app/controllers/#{name}_controller.rb", /(#{Regexp.escape(link)})/mi do |match|
      "#{download_route_method}_url(identifier: _upload.identifier)"
    end
  end

  def add_routes
    line = "Rails.application.routes.draw do"
    gsub_file "config/routes.rb", /(#{Regexp.escape(line)})/mi do |match|
      <<-HERE.gsub(/^ {9}/, '')
         #{match}
           post "#{name}", to: "#{name}#create", defaults: { format: :json }
           get "#{name}/:identifier/download", to: "#{name}#download", defaults: { format: :json }, as: :#{download_route_method}
         HERE
    end
  end

  private

  def download_route_method
    "#{name.gsub('/','_')}_download"
  end
end
