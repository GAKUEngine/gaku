namespace :testing do
  desc 'Setup test enviroment'
  task env_setup: :environment do
    Gaku::User.where(username: 'admin').first_or_create(email: 'admin@gakuengine.com', password: '123456')
    Gaku::ContactType.where(name: 'email').first_or_create
  end
end
