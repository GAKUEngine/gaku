# encoding: utf-8
require 'ffaker'

#student
student = Gaku::Student.where(:name => 'John', :surname => 'Doe').first_or_create!

country = Gaku::Country.find_by_name('日本')
address = student.addresses.create(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id)

email = Gaku::ContactType.find_by_name('Email')
home_phone = Gaku::ContactType.find_by_name('Home Phone')
mobile_phone = Gaku::ContactType.find_by_name('Mobile Phone')

student_email = student.contacts.create!(:data => 'john@example.com', :contact_type_id => email.id)
student_home_phone = student.contacts.create!(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id)
student_mobile_phone = student.contacts.create!(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true)

note = Gaku::Note.where(:title => 'Excellent', :content => 'Excellent student').first_or_create!
student.notes << note

#guardian
guardian = Gaku::Guardian.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name)

guardian_email = guardian.contacts.create!(:data => "#{guardian.name}@example.com", :contact_type_id => email.id)
guardian_home_phone =  guardian.contacts.create!(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id)
guardian_mobile_phone =  guardian.contacts.create!(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true)

guardian_address = guardian.addresses.create!(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id)

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
