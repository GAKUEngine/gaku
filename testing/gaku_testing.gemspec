# encoding: UTF-8

require_relative '../common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  include CommonGakuGemspecMixin
  set_common_attributes s

  s.name         = 'gaku_testing'
  s.summary      = 'Shared testing helpers for GAKU Engine'
  s.description  = 'Testing helpers used in other engines/modules for GAKU Engine.'

  s.files        = Dir['lib/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.add_dependency 'gaku_core', s.version
end
