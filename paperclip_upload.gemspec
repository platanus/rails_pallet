$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "paperclip_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "paperclip_upload"
  s.version     = PaperclipUpload::VERSION
  s.authors     = ["Leandro Segovia"]
  s.email       = ["ldlsegovia@gmail.com"]
  s.homepage    = "https://github.com/platanus/paperclip_upload"
  s.summary     = "Rails engine to save paperclip attachments asynchronously"
  s.description = "This gem allows you: 1) perform multiple POST requests to create multiple files. 2) relate those files with a model using identifiers instead the files themselves"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency 'rails', '~> 4.2', '>= 4.2.1'
  s.add_runtime_dependency 'hashids', '~> 1.0', '>= 1.0.2'
  s.add_runtime_dependency 'paperclip', '~> 4.2', '>= 4.2.0'
  s.add_runtime_dependency 'responders', '~> 2.1', '>= 2.1.0'
  s.add_dependency "active_model_serializers", "~> 0.9.3"

  s.add_development_dependency 'rspec-rails', '~> 3.2', '>= 3.2.1'
  s.add_development_dependency "pry-rails", "~> 0.3.3"
  s.add_development_dependency 'factory_girl_rails', '~> 4.5', '>= 4.5.0'
  s.add_development_dependency 'shoulda-matchers', '~> 2.8', '>= 2.8.0'
  s.add_development_dependency 'guard', '~> 2.12', '>= 2.12.5'
  s.add_development_dependency 'guard-rspec', '~> 4.5', '>= 4.5.0'
  s.add_development_dependency 'annotate', '~> 2.6', '>= 2.6.6'
  s.add_development_dependency "sqlite3", '~> 1.3', '>= 1.3.10'
  s.add_development_dependency "recursive-open-struct", "~> 0.6.4"
end
