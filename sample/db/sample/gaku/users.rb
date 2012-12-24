# encoding: utf-8
Gaku::User.create(:email => 'example@example.com', :username => 'example', :password => '123456',   :password_confirmation => '123456')
Gaku::User.create(:email => 'admin@example.com',   :username => 'admin',   :password => 'password', :password_confirmation => 'password')
Gaku::User.create(:email => 'student@example.com', :username => 'student', :password => 'password', :password_confirmation => 'password')
