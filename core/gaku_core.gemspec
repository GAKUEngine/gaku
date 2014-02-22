# encoding: UTF-8
version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_core'
  s.version      = version
  s.summary      = 'GAKU Engine is a student/assignment focused student and school management system'
  s.description  = "It allows for full student management, grading etc. It's basically what all student grading tools are with some unique features"
  s.required_ruby_version = '~> 2.0.0'

  s.authors      = ['Rei Kagetsuki', 'Nakaya Yukiharu', 'Vassil Kalkov', 'Georgi Tapalilov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/gaku'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'rails',                          '~> 4.0.3'
  s.add_dependency 'rails-i18n',                     '~> 4.0.1'

  s.add_dependency 'pg',                             '0.16'

  s.add_dependency 'globalize',                      '~> 4.0.0'
  s.add_dependency 'paperclip',                      '~> 3.5'
  s.add_dependency 'ransack',                        '~> 1.0'
  s.add_dependency 'kaminari',                       '~> 0.14'
  s.add_dependency 'draper',                         '~> 1.0'
  s.add_dependency 'deface',                         '~> 1.0.0'

  s.add_dependency 'devise',                         '~> 3.2.0'
  s.add_dependency 'devise-i18n'
  s.add_dependency 'cancan',                         '~> 1.6.10'

  s.add_dependency 'localeapp'
  s.add_dependency 'highline',                       '1.6.11'
  s.add_dependency 'ffaker',                         '~> 1.19.0'
  s.add_dependency 'rake-progressbar'
end
