# encoding: utf-8
require 'ffaker'
require 'rake-progressbar'

#student
student = Gaku::Student.where(:name => 'John', :surname => 'Doe', :enrollment_status_id => 2).first_or_create!

country = Gaku::Country.where(:name => '日本', iso3: 'JPN', iso: 'JP', iso_name: 'JAPAN', numcode: "392").first_or_create!
address = student.addresses.where(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id).first_or_create!

email = Gaku::ContactType.where(:name => 'Email').first_or_create!
home_phone = Gaku::ContactType.where(:name => 'Home Phone').first_or_create!
mobile_phone = Gaku::ContactType.where(:name => 'Mobile Phone').first_or_create!

unless student.contacts.count > 3
  student_email = student.contacts.where(:data => 'john@example.com', :contact_type_id => email.id).first_or_create!
  student_home_phone = student.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id).first_or_create!
  student_mobile_phone = student.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true).first_or_create!
end

note = Gaku::Note.where(:title => 'Excellent', :content => 'Excellent student').first_or_create!
student.notes << note


guardian = Gaku::Guardian.where(:name => Faker::Name.first_name, :surname => Faker::Name.last_name).first_or_create!

unless guardian.addresses.count > 1
  guardian_email = guardian.contacts.where(:data => "#{guardian.name}@example.com", :contact_type_id => email.id).first_or_create!
  guardian_home_phone =  guardian.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => home_phone.id).first_or_create!
  guardian_mobile_phone =  guardian.contacts.where(:data => Faker::PhoneNumber.phone_number, :contact_type_id => mobile_phone.id, :is_primary => true).first_or_create!

  guardian.addresses.where(:address1 => Faker::Address.street_address, :city => 'Nagoya', :country_id => country.id).first_or_create!
end

unless student.guardians.count > 1
  student.guardians << guardian
end

students = [
  { :name => 'Anonime', :surname => 'Anonimized', :enrollment_status_id => 2 },
  { :name => 'Amon', :surname => 'Tobin', :enrollment_status_id => 2 },
  { :name => '零', :surname => '影月', :enrollment_status_id => 2 },
  { :name => 'サニー', :surname => 'スノー', :enrollment_status_id => 2 }
]

students.each do |student|
  Gaku::Student.where(student).first_or_create!
end


students_count = 1000

unless Gaku::Student.count > students_count
  bar = RakeProgressbar.new(students_count)
  students_count.times do
    Gaku::Student.create!(:name => Faker::Name.first_name, :surname => Faker::Name.last_name, :enrollment_status_id => 2)
    bar.inc
  end
  bar.finished
end
