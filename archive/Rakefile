require 'rubygems'
require 'bundler'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'gaku/testing/common_rake'

Bundler::GemHelper.install_tasks

spec = eval(File.read('gaku_archive.gemspec'))
Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc 'Release to gemcutter'
task :release do
  version = File.read(
    File.expand_path('../../VERSION', __FILE__)).strip
  cmd = "cd pkg && gem push gaku_archive-#{version}.gem"
  puts cmd
  system cmd
end

task default: :spec

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'gaku/archive'
  Rake::Task['common:test_app'].invoke
end
