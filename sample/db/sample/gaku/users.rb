# encoding: utf-8

users = [

  {
    :email => 'example@example.com',
    :username => 'example',
    :password => '123456',
    :password_confirmation => '123456'
  },

  {
    :email => 'admin@example.com',
    :username => 'admin',
    :password => '123456',
    :password_confirmation => '123456'
  },

  {
    :email => 'student@example.com',
    :username => 'student',
    :password => '123456',
    :password_confirmation => '123456'
  },

  {
    :email => 'guardian@example.com',
    :username => 'guardian',
    :password => '123456',
    :password_confirmation => '123456'
  }

]

users.each do |user|
  Gaku::User.where(:email => user[:email]).first_or_create!(:username => user[:username],
                                                            :password => user[:password],
                                                            :password_confirmation => user[:password_confirmation]
                                                           )
end

admin_user = Gaku::User.find_by_username('admin')
admin_role = Gaku::Role.find_by_name('Admin')
admin_user.roles << admin_role
admin_user.save!

student_user = Gaku::User.find_by_username('student')
student_role = Gaku::Role.find_by_name('Student')
student_user.roles << student_role
student_user.save!

guardian_user = Gaku::User.find_by_username('guardian')
guardian_role = Gaku::Role.find_by_name('Guardian')
guardian_user.roles << guardian_role
guardian_user.save!
