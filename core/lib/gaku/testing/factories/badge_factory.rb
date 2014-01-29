FactoryGirl.define do

  factory :badge, class: Gaku::Badge do
    student
    badge_type

    factory :invalid_badge do
      student nil
    end
  end

end
