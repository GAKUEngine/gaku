# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_core'
  s.version      = '0.0.1'
  s.summary      = 'GAKU Engine is a student/assignment focused student and school management system'
  s.description  = "It allows for full student management, grading etc. It's bascally what all student grading tools are with some unique features"
  s.required_ruby_version = '>= 1.8.7'

  s.authors      = ['Rei Kagetsuki', 'Nakaya Yukiharu', 'Vassil Kalkov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/GAKUEngine'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'
  s.add_dependency 'rails', '~> 3.2.8'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'slim-rails'
  s.add_dependency 'audited-activerecord', '~> 3.0'
  s.add_dependency 'inherited_resources'
  s.add_dependency 'jquery-rails', '~> 2.0'
  s.add_dependency 'i18n-js'
  s.add_dependency 'backbone-on-rails'
  s.add_dependency 'underscore'
  s.add_dependency 'highline', '= 1.6.11'
  s.add_dependency 'paperclip'
  s.add_dependency 'ransack'
  s.add_dependency 'devise'
  s.add_dependency 'cancan'
  s.add_dependency 'app_config'
  s.add_dependency 'eco'
end
