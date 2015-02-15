require 'rubygems'
require 'bundler'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'gaku/testing/common_rake'

Bundler::GemHelper.install_tasks

task default: :spec

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'gaku/admin'
  Rake::Task['common:test_app'].invoke
end
