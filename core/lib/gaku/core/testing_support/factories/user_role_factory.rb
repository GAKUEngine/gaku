FactoryGirl.define do

  factory :user_role, class: Gaku::UserRole do
    user
    role
  end

end
