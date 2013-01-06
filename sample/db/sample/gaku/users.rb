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
    :password => 'password',
    :password_confirmation => 'password'
  },

  {
    :email => 'student@example.com',
    :username => 'student',
    :password => 'password',
    :password_confirmation => 'password'
  }

]

users.each do |user|
  Gaku::User.where(:email => user[:email]).first_or_create!(:username => user[:username],
                                                            :password => user[:password],
                                                            :password_confirmation => user[:password_confirmation]
                                                           )
end
