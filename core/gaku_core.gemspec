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

  s.add_dependency 'rails',             '~> 5.2.2'
  s.add_dependency 'rails-i18n',        '~> 5.1.2'
  s.add_dependency 'pg',                '~> 1.1.4'
  s.add_dependency 'redis',             '~> 4.1.0'
  s.add_dependency 'carmen',            '~> 1.1.1'
  s.add_dependency 'listen'
  s.add_dependency 'activemodel-serializers-xml'
  s.add_dependency 'paperclip',         '~> 6.1.0'
  s.add_dependency 'ransack',           '~> 2.1.1'
  s.add_dependency 'kaminari',          '~> 1.1.1'
  s.add_dependency 'draper',            '~> 3.0.1'
  s.add_dependency 'devise',            '~> 4.5.0'
  s.add_dependency 'devise-i18n'
  s.add_dependency 'cancan',            '~> 1.6.10'
  s.add_dependency 'highline'
  s.add_dependency 'ffaker',            '~> 2.10.0'
  s.add_dependency 'rake-progressbar'
  s.add_dependency 'globalize', '~> 5.2.0'
end
