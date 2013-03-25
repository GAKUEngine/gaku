FactoryGirl.define do
  factory :school_level, :class => Gaku::SchoolLevel do
    title 'High 3'
    association(:school)
  end
end
