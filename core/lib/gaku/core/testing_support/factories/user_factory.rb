FactoryGirl.define do
  factory :user, :class => Gaku::User do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
  end

  factory :admin, :parent => :user do
    #admin true
    after_create do |user|
      role = FactoryGirl.create(:admin_role)
      FactoryGirl.create(:user_role, :role => role, :user => user)
    end
  end
end
