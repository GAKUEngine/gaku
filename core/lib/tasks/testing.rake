namespace :testing do
  desc 'Setup test enviroment'
  task env_setup: :environment do
    admin_role = Gaku::Role.where(name: 'admin').first_or_create

    user = Gaku::User.where(username: 'admin').first_or_create(email: 'admin@gakuengine.com', password: '123456')
    user.roles << admin_role

    Gaku::ContactType.where(name: 'email').first_or_create
    Gaku::EnrollmentStatus.where(name: 'enrolled', code: 'enrolled', active: true).first_or_create
  end
end
