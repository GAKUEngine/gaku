def set_gaku_gemspec_shared(s)
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1.3'

  s.version     = File.read(File.expand_path('../VERSION', __FILE__)).strip

  s.authors     = ['Rei Kagetsuki', 'Georgi Tapalilov', 'Nakaya Yukiharu', 'Vassil Kalkov']
  s.email       = 'info@gakuengine.com'
  s.homepage    = 'http://www.gakuengine.com'
  s.licenses    = ['GPL-3.0', 'AGPL-3.0']
end
