# encoding: UTF-8

require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name        = 'gaku_sample'
  s.summary     = 'Sample data for use with GAKU Engine'
  s.description = 'Just some sample data'


  s.files        = Dir['LICENSE', 'README.md', 'lib/**/*', 'db/**/*']
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'gaku_core', s.version
end
