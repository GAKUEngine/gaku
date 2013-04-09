FactoryGirl.define do

  factory :contact, :class => Gaku::Contact do
    data "gaku@example.com"
    association(:contact_type)
    details "My email"
  end

end
