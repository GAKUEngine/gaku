FactoryGirl.define  do

  factory :school_role, class: Gaku::SchoolRole do
    sequence(:name) { |n| "school_role#{n}" }
  end

end
