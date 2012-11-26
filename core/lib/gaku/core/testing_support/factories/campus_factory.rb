FactoryGirl.define do
  factory :campus, :class => Gaku::Campus do
    name "Takiko Campus"
    association(:address)
    association(:school)
  end
end