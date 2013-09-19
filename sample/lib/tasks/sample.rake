#require 'ffaker'
require 'sample_counters'
require 'benchmark'

namespace :db do
  desc 'Loads sample data'
  task :sample do

    say "Simple mode: #{@simple_sample_counts.to_json}".yellow
    say "Normal mode: #{@normal_sample_counts.to_json}".yellow
    say "Full mode: #{@full_sample_counts.to_json}".yellow
    say "------------------------------------------------------------------------------------------------".green

    mode = ENV['mode']
    if mode.nil?
      choose do |menu|
        menu.prompt = "Please choose a mode  ".yellow

        menu.choice(:simple) { simple_mode }
        menu.choice(:normal) { normal_mode }
        menu.choice(:full) { full_mode }
      end
    else
      resolve_mode(mode)
    end

    time = Benchmark.realtime do
      say "Resetting database ..."
      Rake::Task["db:reset"].invoke

      sample_path = File.join(File.dirname(__FILE__), '..', '..', 'db', 'sample')
      Rake::Task['db:load_dir'].reenable
      Rake::Task['db:load_dir'].invoke(sample_path)
    end

    say "Time elapsed #{human_time(time)}"
  end
end


private

def human_time(time)
  mm, ss = time.divmod(60)
  say("%d minutes and %d seconds".green % [mm, ss])
end

def simple_mode
  say "Running in simple mode ...".yellow
  @count = @simple_sample_counts
end

def normal_mode
  say "Running in normal mode ...".yellow
  @count = @normal_sample_counts
end

def full_mode
  say "Running in full mode ...".yellow
  @count = @full_sample_counts
end

def resolve_mode(mode)
  if mode == 'full'
    full_mode
  elsif mode == 'normal'
    normal_mode
  elsif mode == 'simple'
    simple_mode
  else
    normal_mode
  end
end