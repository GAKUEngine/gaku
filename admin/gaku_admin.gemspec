# encoding: UTF-8

require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name         = 'gaku_admin'
  s.summary      = 'Admin module for GAKU Engine'
  s.description  = 'Admin Panel and functionality for GAKU Engine. See https://github.com/GAKUEngine/gaku'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'gaku_core', s.version
  s.add_dependency 'gaku_testing', s.version
  s.add_dependency 'gaku_frontend', s.version
end
