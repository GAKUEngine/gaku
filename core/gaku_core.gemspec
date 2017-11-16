require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name         = 'gaku_core'
  s.summary      = 'GAKU Engine core module'
  s.description  = 'Core functionality for GAKU Engine. See https://github.com/GAKUEngine/gaku'

  s.files        = ['gaku_core.gemspec', "app/**/*", "config/**/*", "lib/**/*", "db/**/*",
                    "vendor/**/*"]
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'rails',             '~> 5.1.4'
  s.add_dependency 'rails-i18n',        '~> 5.0.3'
  s.add_dependency 'pg',                '~> 0.19'
  s.add_dependency 'redis',             '~> 3.3.3'
  s.add_dependency 'carmen',            '~> 1.0.2'
  s.add_dependency 'activemodel-serializers-xml'
  s.add_dependency 'paperclip',         '~> 5.1.0'
  s.add_dependency 'ransack',           '~> 1.8.2'
  s.add_dependency 'kaminari',          '~> 1.0.1'
  s.add_dependency 'draper',            '~> 3.0.1'
  s.add_dependency 'devise',            '~> 4.3.0'
  s.add_dependency 'devise-i18n'
  s.add_dependency 'cancan',            '~> 1.6.10'
  s.add_dependency 'highline'
  s.add_dependency 'ffaker',            '~> 2.5.0'
  s.add_dependency 'rake-progressbar'
  s.add_dependency 'globalize'
end
