# encoding: UTF-8
version = File.read(File.expand_path("../../GAKU_ENGINE_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'gaku_sample'
  s.version     = version
  s.summary     = 'Sample data for use with GAKU Engine'
  s.description = 'Required dependency for GAKU Engine'

  s.required_ruby_version = '>= 1.9.2'
  s.author      = 'Vassil Kalkov'
  s.email       = 'info@genshin.org'
  s.homepage    = 'http://github.com/Genshin/GAKUEngine'

  s.files        = Dir['LICENSE', 'README.md', 'lib/**/*', 'db/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'gaku_core', version
  s.add_dependency 'ffaker'
end