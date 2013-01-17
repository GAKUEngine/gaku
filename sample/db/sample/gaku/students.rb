# encoding: utf-8
require 'ffaker'

#student
student = Gaku::Student.where(:name => 'John', :surname => 'Doe', :enrollment_status_id => 2).first_or_create!

country = Gaku::Country.find_by_name('日本')
address = student.addresses.where(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id).first_or_create!

email = Gaku::ContactType.find_by_name('Email')
home_phone = Gaku::ContactType.find_by_name('Home Phone')
mobile_phone = Gaku::ContactType.find_by_name('Mobile Phone')

student_email = student.contacts.where(:data => 'john@example.com', :contact_type_id => email.id).first_or_create!
student_home_phone = student.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id).first_or_create!
student_mobile_phone = student.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true).first_or_create!

note = Gaku::Note.where(:title => 'Excellent', :content => 'Excellent student').first_or_create!
student.notes << note

#guardian
guardian = Gaku::Guardian.where(:name => Faker::Name.first_name, :surname => Faker::Name.last_name).first_or_create!

guardian_email = guardian.contacts.where(:data => "#{guardian.name}@example.com", :contact_type_id => email.id).first_or_create!
guardian_home_phone =  guardian.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id).first_or_create!
guardian_mobile_phone =  guardian.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true).first_or_create!

guardian_address = guardian.addresses.where(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id).first_or_create!

student.guardians << guardian

students = [
  { :name => 'Anonime', :surname => 'Anonimized', :enrollment_status_id => 2 },
  { :name => 'Amon', :surname => 'Tobin', :enrollment_status_id => 2 },
  { :name => '零', :surname => '影月', :enrollment_status_id => 2 },
  { :name => 'サニー', :surname => 'スノー', :enrollment_status_id => 2 }
]

students.each do |student|
  Gaku::Student.where(student).first_or_create!
end

unless Gaku::Student.count > 50
  50.times do
    Gaku::Student.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name, :enrollment_status_id => 2)
  end
end
