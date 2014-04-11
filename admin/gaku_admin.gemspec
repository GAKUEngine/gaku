# encoding: UTF-8
version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_admin'
  s.version      = version
  s.summary      = 'Admin engine for GAKU'
  s.description  = "It allows basic admin functionality"
  s.required_ruby_version = '~> 2.0.0'

  s.authors      = ['Rei Kagetsuki', 'Nakaya Yukiharu', 'Vassil Kalkov', 'Georgi Tapalilov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/gaku'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'gaku_core', version
  s.add_dependency 'gaku_testing', version

  s.add_dependency 'coffee-rails',                   '~> 4.0.1'
  s.add_dependency 'sass-rails',                     '4.0.2'
  s.add_dependency 'sass',                           '~> 3.2'
  s.add_dependency 'sprockets',                      '2.11.0'
  s.add_dependency 'slim',                           '2.0.0'
  s.add_dependency 'responders',                     '~> 1.0'

  s.add_dependency 'rails4_client_side_validations', '0.0.3'

  s.add_dependency 'phantom_helpers',                '0.11.0.alpha6'
  s.add_dependency 'phantom_forms',                  '0.2.0.alpha5'
  s.add_dependency 'phantom_nested_forms',           '0.2.0.alpha4'

  s.add_dependency 'nested_form'

  s.add_dependency 'jquery-rails',                   '~> 3.1'
  s.add_dependency 'jquery-ui-rails',                '~> 4.2'
  s.add_dependency 'jquery-minicolors-rails',        '2.1.1'
  s.add_dependency 'bootstrap-sass',                 '~> 3.1.1.0'
  s.add_dependency 'bootstrap-datepicker-rails',     '~> 1.3.0.1'
  s.add_dependency 'nprogress-rails'
  s.add_dependency 'underscore-rails',               '~> 1.5.2'
  s.add_dependency 'momentjs-rails',                 '~> 2.5.1'
  s.add_dependency 'remotipart',                     '~> 1.2.1'
end
