FactoryGirl.define do
  factory :user, :class => Gaku::User do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
  end

  factory :admin, :parent => :user do
    after_create do |user|
      role = FactoryGirl.create(:admin_role)
      FactoryGirl.create(:user_role, :role => role, :user => user)
    end
  end

  factory :student_user, :parent => :user do
    after_create do |user|
      role = FactoryGirl.create(:student_role)
      FactoryGirl.create(:user_role, :role => role, :user => user)
    end
  end


  factory :principal_user, :parent => :user do
    after_create do |user|
      role = FactoryGirl.create(:principal_role)
      FactoryGirl.create(:user_role, :role => role, :user => user)
    end
  end

  factory :vice_principal_user, :parent => :user do
    after_create do |user|
      role = FactoryGirl.create(:vice_principal_role)
      FactoryGirl.create(:user_role, :role => role, :user => user)
    end
  end

end
