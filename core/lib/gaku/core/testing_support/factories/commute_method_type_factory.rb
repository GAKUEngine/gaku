FactoryGirl.define do
  factory :commute_method_type, :class => Gaku::CommuteMethodType do
    name "Car"
    after_build do |type|
      type.commute_methods << FactoryGirl.build(:commute_method, :commute_method_type_id => type.id)
    end
  end
end
