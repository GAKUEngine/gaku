require 'rake'
require 'rubygems/package_task'
require 'thor/group'
require_relative './core/lib/generators/gaku/install/install_generator'
begin
  require 'gaku/testing/common_rake'
rescue LoadError
  raise 'Could not find gaku/testing/common_rake. You need to run this command using Bundler.'
end

engines = %w( core admin frontend sample testing api )

task default: :all_specs

desc 'Generates a dummy app for testing for every GAKU engine'
task :test_app do
  engines.each do |engine|
    ENV['LIB_NAME'] = File.join('gaku', engine)
    ENV['DUMMY_PATH'] = File.expand_path("../#{engine}/spec/dummy", __FILE__)
    Rake::Task['common:test_app'].execute
  end
end

desc 'Clean the whole repository by removing all the generated files'
task :clean do
  puts 'Deleting pkg directory..'
  FileUtils.rm_rf('pkg')

  engines.each do |gem_name|
    puts "Cleaning #{gem_name}:"
    puts "  Deleting #{gem_name}/Gemfile"
    FileUtils.rm_f("#{gem_name}/Gemfile")
    puts "  Deleting #{gem_name}/pkg"
    FileUtils.rm_rf("#{gem_name}/pkg")
    puts "  Deleting #{gem_name}'s dummy application"
    Dir.chdir("#{gem_name}/spec") do
      FileUtils.rm_rf('dummy')
    end
  end
end

namespace :gem do
  desc 'Build all gems'
  task :build do
    engines.each do |gem_name|
      puts "〓〓〓⚙学〓〓〓🔨 Building #{gem_name}🔨 〓〓〓⚙学〓〓〓"
      cmd = "cd #{gem_name} && gem build gaku_#{gem_name}.gemspec"
      puts cmd
      system cmd
    end
    puts "〓〓〓⚙学〓〓〓🔨 Building gaku🔨 〓〓〓⚙学〓〓〓"
    cmd = 'gem build gaku.gemspec'
    puts cmd
    system cmd
  end

  desc 'Install all gems'
  task :install do
    version = File.read(File.expand_path('../VERSION', __FILE__)).strip

    engines.each do |gem_name|
      puts "〓〓〓⚙学〓〓〓⭳Installing #{gem_name}⭳〓〓〓⚙学〓〓〓"
      cmd = "gem install ./#{gem_name}/gaku_#{gem_name}-#{version}.gem"
      puts cmd
      system cmd
    end
    puts "〓〓〓⚙学〓〓〓⭳Installing gaku⭳〓〓〓⚙学〓〓〓"
    cmd = "gem install ./gaku-#{version}.gem"
    puts cmd
    system cmd
  end

  desc 'Release all gems to gemcutter. Package gaku components, then push gaku'
  task :release do
    version = File.read(File.expand_path('../VERSION', __FILE__)).strip

    engines.each do |gem_name|
      puts "〓〓〓⚙学〓〓〓⭜ Releasing #{gem_name}⭝ 〓〓〓⚙学〓〓〓"
      cmd = "gem push ./#{gem_name}/gaku_#{gem_name}-#{version}.gem"
      puts cmd
      system cmd
    end
    puts "〓〓〓⚙学〓〓〓⭜ Releasing gaku⭝ 〓〓〓⚙学〓〓〓"
    cmd = "gem push ./gaku-#{version}.gem"
    puts cmd
    system cmd
  end
end
