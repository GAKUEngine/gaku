# encoding: utf-8

users = [

  {
    email: 'example@example.com',
    username: 'example',
    password: '123456',
    password_confirmation: '123456'
  },

  {
    email: 'admin@example.com',
    username: 'admin',
    password: '123456',
    password_confirmation: '123456'
  },

  {
    email: 'student@example.com',
    username: 'student',
    password: '123456',
    password_confirmation: '123456'
  },

  {
    email: 'guardian@example.com',
    username: 'guardian',
    password: '123456',
    password_confirmation: '123456'
  }

]

users.each do |user|
  Gaku::User.where(username: user[:username]).first_or_create!(email: user[:email],
                                                               password: user[:password],
                                                               password_confirmation: user[:password_confirmation]
                                                           )
end

admin_user = Gaku::User.find_by_username('admin')
admin_role = Gaku::Role.find_by_name('Admin')
admin_user.roles << admin_role

student_user = Gaku::User.find_by_username('student')
student_role = Gaku::Role.find_by_name('Student')
student_user.roles << student_role

guardian_user = Gaku::User.find_by_username('guardian')
guardian_role = Gaku::Role.find_by_name('Guardian')
guardian_user.roles << guardian_role

say "Creating #{@count[:users]} users...".yellow

batch_create(@count[:teachers]) do
  Gaku::User.where(username: Faker::Name.first_name, email: Faker::Internet.email).first_or_create( password: '123456', password_confirmation: '123456')
end

