FactoryGirl.define do


  factory :user do
    email { Faker::Internet.email }
    login { email }
    password 'secret'
    password_confirmation 'secret'

  end
end