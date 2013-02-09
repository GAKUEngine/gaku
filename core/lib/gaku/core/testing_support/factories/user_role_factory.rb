FactoryGirl.define do
  factory :user_role, :class => Gaku::UserRole do
    association(:user)
    association(:role)
  end

end
