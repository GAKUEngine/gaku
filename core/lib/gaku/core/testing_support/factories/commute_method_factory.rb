FactoryGirl.define do
  factory :commute_method, :class => Gaku::CommuteMethod do
    association(:commute_method_type)
  end
end
