require 'rake'
require 'bundler'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'rspec/core/rake_task'

require File.expand_path('../config/application', __FILE__)

GAKUEngine::Application.load_tasks
Bundler::GemHelper.install_tasks
Bundler.setup
RSpec::Core::RakeTask.new

task :all_tests => [:environment] do
  ["rake spec"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end

desc "Generates a dummy app for testing"
task :test_app do
  Rails.env = "test"
  puts "Setting up dummy database..."
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:test:prepare'].invoke
end


task :default => [:all_tests]

spec = eval(File.read('gaku_engine.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end
