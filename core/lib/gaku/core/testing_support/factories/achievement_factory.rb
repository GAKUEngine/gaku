FactoryGirl.define do
  factory :achievement, :class => Gaku::Achievement do
    name 'credits'
    description 'some helpful achievement'

    association(:student)
    association(:school)
  end
end
