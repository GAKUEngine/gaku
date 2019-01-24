FactoryBot.define do
  factory :commute_method_type, class: Gaku::CommuteMethodType do
    name 'Car'

    factory :invalid_commute_method_type do
      name nil
    end
  end
end
