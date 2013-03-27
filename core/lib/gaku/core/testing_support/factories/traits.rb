FactoryGirl.define do

  trait :with_note do
    after_create do |resource|
      FactoryGirl.create(:note, :notable => resource)
    end
  end

  trait :with_notes do
    after_create do |resource|
      FactoryGirl.create(:note, :notable => resource)
      FactoryGirl.create(:note, :notable => resource)
    end
  end


  trait :with_address do
    after_create do |resource|
      resource.addresses << FactoryGirl.create(:address, :addressable => resource)
      resource.save
    end
  end

  trait :with_addresses do
    after_create do |resource|
      resource.addresses << FactoryGirl.create(:address, :addressable => resource)
      resource.addresses << FactoryGirl.create(:address, :addressable => resource)
      resource.save
    end
  end

  trait :with_contact do
    after_create do |resource|
      resource.contacts << FactoryGirl.create(:contact, :contactable => resource)
      resource.save
    end
  end

  trait :with_contacts do
    after_create do |resource|
      resource.contacts << FactoryGirl.create(:contact, :contactable => resource)
      resource.contacts << FactoryGirl.create(:contact, :contactable => resource)
      resource.save
    end
  end

end
