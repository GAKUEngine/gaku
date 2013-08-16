FactoryGirl.define do

  factory :contact, class: Gaku::Contact do
    data 'gaku@example.com'
    details 'My email'
    contact_type
  end

end
