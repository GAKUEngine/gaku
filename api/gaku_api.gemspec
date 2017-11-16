require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name          = 'gaku_api'
  s.summary       = 'GAKU Engine API module'
  s.description   = 'API functionality for GAKU Engine. See https://github.com/GAKUEngine/gaku'

  s.files         = ['gaku_api.gemspec', "{app,config,db,lib}/**/*", 'Rakefile']

  s.add_dependency 'simple_command'
  s.add_dependency 'jwt'
  s.add_dependency 'active_model_serializers'
  s.add_dependency 'msgpack_rails'
  s.add_dependency 'kaminari'

  s.add_dependency 'gaku_core', s.version

  s.add_development_dependency 'gaku_testing', s.version
end
