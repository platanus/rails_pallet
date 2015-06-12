$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "paperclip_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "paperclip_upload"
  s.version     = PaperclipUpload::VERSION
  s.authors     = ["Leandro Segovia"]
  s.email       = ["ldlsegovia@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "rspec-rails", "~> 3.2.1"
  s.add_development_dependency "pry-rails", "~> 0.3.3"
  s.add_development_dependency "factory_girl_rails", "~> 4.5.0"
  s.add_development_dependency "shoulda-matchers", "~> 2.8.0"
  s.add_development_dependency "guard", "~> 2.12.5"
  s.add_development_dependency "guard-rspec", "~> 4.5.0"

  s.add_development_dependency "sqlite3"
end
