FactoryGirl.define do
  factory :campus, :class => Gaku::Campus do
    name "Takiko Campus"
    association(:school)
  end

  trait :with_address do
    after_create do |campus|
      campus.address = FactoryGirl.create(:address, :addressable => campus)
      campus.save
    end
  end

end
