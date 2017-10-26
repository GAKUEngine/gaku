# encoding: UTF-8

require_relative 'common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  set_gaku_gemspec_shared s

  s.name         = 'gaku'
  s.summary      = 'GAKU Engine - Dynamic Open Source School Management'
  s.description  = \
    'GAKU Engine is a highly customizable Open Source School Management System. ' +
    'It offers extensions to exceed the bounds of a standardized curriculum, ' +
    'and original tools to augment the learning experience.' +
    'It is the engine to drive a more dynamic education.'
  s.post_install_message =  \
    "╔═════════════════════════╼\n" +
    "║⚙学 GAKU Engine [学エンジン] V.#{s.version.to_s}\n" +
    "╟─────────────────────────╼\n" +
    "║©2014 幻信創造株式会社 [Phantom Creation Inc.]\n" +
    "║http://www.gakuengine.com\n" +
    "╟─────────────────────────╼\n" +
    "║Thank you for installing GAKU Engine!\n" +
    "║GAKU Engine is Open Source [GPL/AGPL] Software.\n" +
    "╚═════════════════════════╼\n" 

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'gaku_core', s.version
  s.add_dependency 'gaku_admin', s.version
  s.add_dependency 'gaku_frontend', s.version
  s.add_dependency 'gaku_api', s.version
  s.add_dependency 'gaku_testing', s.version
  s.add_dependency 'gaku_sample', s.version
end
