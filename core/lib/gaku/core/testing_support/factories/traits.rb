FactoryGirl.define do

  trait :with_note do
    after_create do |resource|
      FactoryGirl.create(:note, :notable => resource)
      resource.notes.reload
    end
  end

  trait :with_notes do
    after_create do |resource|
      FactoryGirl.create_list :note, 2, :notable => resource
      resource.notes.reload
    end
  end


  trait :with_address do
    after_create do |resource|
      FactoryGirl.create(:address, :addressable => resource)
      resource.addresses.reload
    end
  end

  trait :with_addresses do
    after_create do |resource|
      FactoryGirl.create_list :address, 2, :addressable => resource
      resource.addresses.reload
    end
  end

  trait :with_contact do
    after_create do |resource|
      FactoryGirl.create(:contact, :contactable => resource)
      resource.contacts.reload
    end
  end

  trait :with_contacts do
    after_create do |resource|
      FactoryGirl.create_list :contact, 2, :contactable => resource
      resource.contacts.reload
    end
  end

end
