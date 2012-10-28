FactoryGirl.define do
  factory :user, :class => Gaku::User do
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
  end

  factory :admin, :parent => :user do
    admin true
  end
end
