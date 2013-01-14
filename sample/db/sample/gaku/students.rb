# encoding: utf-8
require 'ffaker'

#student
student = Gaku::Student.where(:name => 'John', :surname => 'Doe').first_or_create!

country = Gaku::Country.find_by_name('日本')
# address = Gaku::Address.where(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id).first_or_create!
# Gaku::StudentAddress.where(:student_id => student.id, :address_id => address.id).first_or_create!

email = Gaku::ContactType.find_by_name('Email')
home_phone = Gaku::ContactType.find_by_name('Home Phone')
mobile_phone = Gaku::ContactType.find_by_name('Mobile Phone')

student_email = Gaku::Contact.where(:data => 'john@example.com', :contact_type_id => email.id).first_or_create!
student_home_phone = Gaku::Contact.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id).first_or_create!
student_mobile_phone = Gaku::Contact.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true).first_or_create!

student.contacts << [student_email, student_home_phone, student_mobile_phone]

note = Gaku::Note.where(:title => 'Excellent', :content => 'Excellent student').first_or_create!
student.notes << note

#guardian
guardian = Gaku::Guardian.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name)

guardian_email = Gaku::Contact.create!(:data => "#{guardian.name}@example.com", :contact_type_id => email.id)
guardian_home_phone = Gaku::Contact.create!(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id)
guardian_mobile_phone = Gaku::Contact.create!(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true)

guardian.contacts << [guardian_email, guardian_home_phone, guardian_mobile_phone]

# guardian_address = Gaku::Address.create!(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id)
# Gaku::GuardianAddress.where(:guardian_id => guardian.id, :address_id => guardian_address.id).first_or_create!

student.guardians << guardian

students = [
  { :name => 'Anonime', :surname => 'Anonimized' },
  { :name => 'Amon', :surname => 'Tobin' },
  { :name => '零', :surname => '影月' },
  { :name => 'サニー', :surname => 'スノー'}
]

students.each do |student|
  Gaku::Student.where(student).first_or_create!
end

unless Gaku::Student.count > 50
  50.times do
    Gaku::Student.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name)
  end
end
