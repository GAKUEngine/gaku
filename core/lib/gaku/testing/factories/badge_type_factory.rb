FactoryGirl.define do

  factory :badge_type, class: Gaku::BadgeType do
    name 'credits'
    description 'some helpful achievement'

    factory :invalid_badge_type do
      name nil
    end
  end

end
