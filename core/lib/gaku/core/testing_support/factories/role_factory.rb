FactoryGirl.define do
  factory :role, :class => Gaku::Role do
    name "Role #1"
  end

  factory :admin_role, :parent => :role do
    name 'admin'
  end
end
