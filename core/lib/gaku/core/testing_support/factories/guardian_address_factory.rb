FactoryGirl.define do
  factory :guardian_address, :class => Gaku::GuardianAddress do
    association(:address)
    association(:guardian)
  end
end
