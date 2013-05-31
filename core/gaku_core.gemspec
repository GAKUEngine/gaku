# encoding: UTF-8
version = File.read(File.expand_path("../../GAKU_ENGINE_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_core'
  s.version      = version
  s.summary      = 'GAKU Engine is a student/assignment focused student and school management system'
  s.description  = "It allows for full student management, grading etc. It's bascally what all student grading tools are with some unique features"
  s.required_ruby_version = '>= 1.9.2'

  s.authors      = ['Rei Kagetsuki', 'Nakaya Yukiharu', 'Vassil Kalkov', 'Georgi Tapalilov', 'Radoslav Georgiev', 'Marta Kostova']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/GAKUEngine'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'rails', '4.0.0.rc1'
  s.add_dependency 'turbolinks'
  s.add_dependency 'jbuilder', '~> 1.0.1'
  s.add_dependency 'protected_attributes'

  s.add_dependency 'slim', '~> 1.3.8'
  #s.add_dependency 'deface'
  s.add_dependency 'inherited_resources'
  s.add_dependency 'responders'
  s.add_dependency 'paper_trail'

  s.add_dependency 'nested_form'
  s.add_dependency 'gaku_helpers'

  s.add_dependency 'rails4_client_side_validations', '0.0.3'
  s.add_dependency 'gaku_forms', '~> 0.1.0'
  s.add_dependency 'gaku_nested_forms', '~> 0.1.0'

  s.add_dependency 'rails-i18n'
  s.add_dependency 'localeapp'
  s.add_dependency 'i18n-js'

  s.add_dependency 'jquery-rails', '~> 2.3.0'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'jquery-turbolinks'
  s.add_dependency 'eco'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'bootstrap-editable-rails'

  s.add_dependency 'highline', '= 1.6.11'
  s.add_dependency 'rake-progressbar'
  s.add_dependency 'paperclip'
  s.add_dependency 'ransack'

  #spreadsheet handling
  s.add_dependency 'roo'
  s.add_dependency 'writeexcel'

  s.add_dependency 'thinreports-rails'

  s.add_dependency 'devise'
  #s.add_dependency 'devise-i18n'
  s.add_dependency 'cancan'

  s.add_dependency 'kaminari'

  s.add_dependency 'foreman'
  s.add_dependency 'sidekiq'
  s.add_dependency 'sinatra'

  s.add_dependency 'globalize3'

end
