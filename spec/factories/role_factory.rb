FactoryGirl.define do
  factory :role do
    name "Role #1"
  end

  factory :admin_role, :parent => :role do
    name 'admin'
  end
end
