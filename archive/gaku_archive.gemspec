# encoding: UTF-8
version = File.read(File.expand_path("../../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_archive'
  s.version      = version
  s.summary      = 'GAKU Engine is a student/assignment focused student and school management system'
  s.description  = "It allows for full student management, grading etc. It's basically what all student grading tools are with some unique features"
  s.required_ruby_version = '~> 2.0.0'

  s.authors      = ['Rei Kagetsuki', 'Nakaya Yukiharu', 'Vassil Kalkov', 'Georgi Tapalilov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/gaku'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*', 'vendor/**/*']
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'

  s.requirements << 'postgresql'
  s.requirements << 'postgresql-contrib'

  s.add_dependency 'gaku_core', version
  s.add_dependency 'gaku_web', version
  s.add_dependency 'gaku_admin', version
  s.add_dependency 'gaku_frontend', version

  s.add_dependency 'paper_trail',                    '3.0.0.beta1'

end
