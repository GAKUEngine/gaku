require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name         = 'gaku_testing'
  s.summary      = 'Shared testing helpers for GAKU Engine'
  s.description  = 'Testing helpers used in other engines/modules for GAKU Engine.'

  s.files        = Dir['lib/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'gaku_core', s.version
end
