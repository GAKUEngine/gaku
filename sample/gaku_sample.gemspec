# encoding: UTF-8
version = File.read(File.expand_path("../../GAKU_ENGINE_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'gaku_sample'
  s.version     = version
  s.summary     = 'Sample data (including images) for use with Gaku.'
  s.description = 'Required dependency for Gaku'

  s.required_ruby_version = '>= 1.8.7'
  s.author      = 'Vassil Kalkov'
  s.email       = 'info@genshin.org'

  s.files        = Dir['LICENSE', 'README.md', 'lib/**/*', 'db/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'gaku_core', version
  s.add_dependency 'ffaker'
end