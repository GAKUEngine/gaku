# encoding: UTF-8

require_relative 'common_gaku_gemspec_mixin'

Gem::Specification.new do |s|
  include CommonGakuGemspecMixin
  set_common_attributes s

  s.name         = 'gaku'
  s.summary      = 'GAKU Engine - Dynamic Open Source School Management'
  s.description  = \
    'GAKU Engine is a highly customizable Open Source School Management System. ' +
    'It offers extensions to exceed the bounds of a standardized curriculum, ' +
    'and original tools to augment the learning experience.' +
    'It is the engine to drive a more dynamic education.'
  s.post_install_message =  \
    '╔═════════════════════════╼' +
    "║⚙学 GAKU Engine [学エンジン] V.#{s.version.to_s}" +
    '╟─────────────────────────╼' +
    '║©2014 幻信創造株式会社 [Phantom Creation Inc.]' +
    '║http://www.gakuengine.com' +
    '╟─────────────────────────╼' +
    '║Thank you for installing GAKU Engine!' +
    '║GAKU Engine is Open Source [GPL/AGPL] Software.' +
    '╚═════════════════════════╼' 

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'gaku_core', s.version
  s.add_dependency 'gaku_admin', s.version
  s.add_dependency 'gaku_frontend', s.version
  s.add_dependency 'gaku_testing', s.version
  s.add_dependency 'gaku_sample', s.version
end
