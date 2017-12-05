namespace :testing do
  desc 'Setup test enviroment'
  task env_setup: :environment do
    Gaku::User.where(username: 'admin').first_or_create(email: 'admin@gakuengine.com', password: '123456')
  end
end
