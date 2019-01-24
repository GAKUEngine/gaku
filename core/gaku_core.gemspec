require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name          = 'gaku_core'
  s.summary       = 'GAKU Engine core module'
  s.description   = 'Core functionality for GAKU Engine. See https://github.com/GAKUEngine/gaku'

  s.files         = Dir.glob('{app,config,db,lib}/**/*') +
                    [
                      'Rakefile',
                      'gaku_core.gemspec'
                    ]
  s.require_path  = 'lib'

  s.requirements  << 'postgresql'
  s.requirements  << 'postgresql-contrib'

  s.add_dependency 'activemodel-serializers-xml'
  s.add_dependency 'cancan'
  s.add_dependency 'carmen'
  s.add_dependency 'devise'
  s.add_dependency 'devise-i18n'
  s.add_dependency 'draper'
  s.add_dependency 'ffaker'
  s.add_dependency 'globalize'
  s.add_dependency 'highline'
  s.add_dependency 'kaminari'
  s.add_dependency 'paperclip'
  s.add_dependency 'pg'
  s.add_dependency 'rails'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'rake-progressbar'
  s.add_dependency 'ransack'
  s.add_dependency 'redis'
end
