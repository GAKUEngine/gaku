# encoding: UTF-8

require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name         = 'gaku_core'
  s.summary      = 'GAKU Engine core module'
  s.description  = 'Core functionality for GAKU Engine. See https://github.com/GAKUEngine/gaku'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'rails',                          '~> 4.2.0'
  s.add_dependency 'rails-i18n',                     '~> 4.0.2'

  s.add_dependency 'pg',                             '~> 0.18'
  s.add_dependency 'redis',                          '~> 3.2'

  s.add_dependency 'globalize',                      '~> 5.0.0'
  s.add_dependency 'paperclip',                      '~> 3.5'
  s.add_dependency 'ransack',                        '~> 1.6.0'
  s.add_dependency 'kaminari',                       '~> 0.15.1'
  s.add_dependency 'draper',                         '~> 1.3.0'
  s.add_dependency 'deface',                         '~> 1.0.0'

  s.add_dependency 'devise',                         '~> 3.4.1'
  s.add_dependency 'devise-i18n'
  s.add_dependency 'cancan',                         '~> 1.6.10'

  s.add_dependency 'highline',                       '1.6.11'
  s.add_dependency 'ffaker',                         '~> 1.23.0'
  s.add_dependency 'rake-progressbar'
end
