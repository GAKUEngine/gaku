FactoryGirl.define do
  factory :school_year, :class => Gaku::SchoolYear do
    starting Time.now
    ending Time.now + 1.year
  end
end
