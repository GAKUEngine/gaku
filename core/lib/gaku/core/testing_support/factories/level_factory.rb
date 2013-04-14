FactoryGirl.define do
  factory :level, :class => Gaku::Level do
    name 'High 3'
    association :school
  end
end
