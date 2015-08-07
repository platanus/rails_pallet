class PaperclipUpload::UploadControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :base_controller, type: :string, :default => "application"

  def generate_controller
    generate "controller #{resource_path} --no-helper --no-assets --no-view-specs --no-controller-specs"
  end

  def replace_controller_with_template
    copy_file "controller.rb", controller_path, force: true
  end

  def customize_controller
    line = "class UploadController < ApplicationController"
    gsub_file controller_path, /(#{Regexp.escape(line)})/mi do |match|
      "class #{controller_class} < #{base_controller_class}"
    end

    link = "\"download_link\""
    gsub_file controller_path, /(#{Regexp.escape(link)})/mi do |match|
      "#{download_route_method}_url(identifier: _upload.identifier)"
    end
  end

  def add_routes
    line = "Rails.application.routes.draw do"
    gsub_file "config/routes.rb", /(#{Regexp.escape(line)})/mi do |match|
      <<-HERE.gsub(/^ {9}/, '')
         #{match}
           post "#{resource_path}", to: "#{resource_path}#create", defaults: { format: :json }
           get "#{resource_path}/:identifier/download", to: "#{resource_path}#download", defaults: { format: :json }, as: :#{download_route_method}
         HERE
    end
  end

  private

  def download_route_method
    "download_#{resource_path.singularize.gsub('/','_')}"
  end

  def controller_class
    "#{name.classify.pluralize}Controller"
  end

  def base_controller_class
    "#{base_controller.classify}Controller"
  end

  def controller_path
    "app/controllers/#{resource_path}_controller.rb"
  end

  def resource_path
    name.tableize
  end
end
