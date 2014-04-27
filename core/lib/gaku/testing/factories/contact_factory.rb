FactoryGirl.define do

  factory :contact, class: Gaku::Contact do
    data 'gaku@example.com'
    details 'My email'
    contact_type

    after(:build) do |contact|
      if contact.contactable.respond_to?(:contacts)
        contact.contactable.contacts.reload
      end
    end

    factory :invalid_contact do
      data nil
    end
  end

end
