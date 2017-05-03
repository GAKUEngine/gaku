$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gaku/api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gaku_api"
  s.version     = Gaku::Api::VERSION
  s.authors     = ["Georgi Tapalilov"]
  s.email       = ["tapalilov@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of Api."
  s.description = "Description of Api."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "simple_command"
  s.add_dependency "jwt"
  s.add_dependency "active_model_serializers"
  s.add_dependency "msgpack_rails"
  s.add_dependency "kaminari"

  s.add_dependency 'gaku_core', s.version
  s.add_dependency 'gaku_testing', s.version



  s.add_development_dependency "sqlite3"
end
