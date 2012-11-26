# encoding: utf-8

Gaku::User.create(:email => 'example@example.com', :password => '123456', :password_confirmation => '123456')
Gaku::User.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
Gaku::User.create(:email => 'student@example.com', :password => 'password', :password_confirmation => 'password')
