# encoding: UTF-8
version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'gaku_sample'
  s.version     = version
  s.summary     = 'Sample data for use with GAKU Engine'
  s.description = 'Just some sample data'

  s.required_ruby_version = '~> 2.0.0'
  s.email       = 'info@genshin.org'
  s.homepage    = 'http://github.com/Genshin/gaku'
  s.authors     = ['Rei Kagetsuki', 'Vassil Kalkov', 'Georgi Tapalilov']

  s.files        = Dir['LICENSE', 'README.md', 'lib/**/*', 'db/**/*']
  s.require_path = 'lib'

  s.requirements << 'postgres'
  s.requirements << 'redis'

  s.add_dependency 'gaku_core', version
end