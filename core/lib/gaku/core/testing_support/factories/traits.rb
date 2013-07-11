FactoryGirl.define do

  trait :with_note do
    after(:create) do |resource|
      FactoryGirl.create(:note, :notable => resource)
      resource.notes.reload
    end
  end

  trait :with_notes do
    after(:create) do |resource|
      FactoryGirl.create_list :note, 2, :notable => resource
      resource.notes.reload
    end
  end


  trait :with_address do
    after(:create) do |resource|
      create(:address, :addressable => resource)
      resource.addresses.reload
    end
  end

  trait :with_addresses do
    after(:create) do |resource|
      FactoryGirl.create_list :address, 2, :addressable => resource
      resource.addresses.reload
    end
  end

  trait :with_contact do
    after(:create) do |resource|
      FactoryGirl.create(:contact, :contactable => resource)
      resource.contacts.reload
    end
  end

  trait :with_contacts do
    after(:create) do |resource|
      FactoryGirl.create_list :contact, 2, :contactable => resource
      resource.contacts.reload
    end
  end

  trait :with_student do
    after(:create) do |resource|
      resource.students << FactoryGirl.create(:student)
      #resource.notes.reload
    end
  end

  trait :with_semesters do
    after(:create) do |resource|
      2.times do
        resource.semesters << FactoryGirl.create(:semester)
      end
    end
  end

  trait :with_semester do
    after(:create) do |resource|
      resource.semesters << FactoryGirl.create(:semester)
    end
  end

end
