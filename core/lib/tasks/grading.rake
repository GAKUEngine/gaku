namespace :gaku do
  namespace :grading do

    desc "!!! Reset DB and delete migrations !!!"
    task setup: :environment do
      system('cd lib/grading; npm install')
    end

  end
end
