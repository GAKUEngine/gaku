require 'ffaker'

after :countries, :contact_types do 

  #student
	student = Student.create(:name => 'John', :surname => 'Doe')

	country = Country.find_by_name('日本')
	address = Address.create(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id)
	StudentAddress.create(:student_id => student.id, :address_id => address.id)

  email = ContactType.find_by_name('E-Mail')
  home_phone = ContactType.find_by_name('Home Phone')
  mobile_phone = ContactType.find_by_name('Mobile Phone')
	student_email = Contact.create(:data => 'john@example.com', :contact_type_id => email.id)
	student_home_phone = Contact.create(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id)
	student_mobile_phone = Contact.create(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true)

	student.contacts << [student_email, student_home_phone, student_mobile_phone]
	
	note = Note.create(:title => 'Excellent', :content => 'Excellent student', :student_id => student.id)
	
	#guardian
	guardian = Guardian.create(:name => Faker::Name.first_name, :surname => Faker::Name.last_name)

	guardian_email = Contact.create(:data => "#{guardian.name}@example.com", :contact_type_id => email.id)
  guardian_home_phone = Contact.create(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id)
	guardian_mobile_phone = Contact.create(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true)

	guardian.contacts << [guardian_email, guardian_home_phone, guardian_mobile_phone]

  guardian_address = Address.create(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id)
	GuardianAddress.create(:guardian_id => guardian.id, :address_id => guardian_address.id)

	student.guardians << guardian

	Student.create(:name => 'Anonime', :surname => 'Anonimized')
	Student.create(:name => 'Amon', :surname => 'Tobin')
	Student.create(:surname => '影月', :name => '零')
	Student.create(:surname => 'スノー', :name => 'サニー')

end