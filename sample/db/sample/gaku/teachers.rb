require 'rake-progressbar'

teachers = [
  { name: 'Vassil', surname: 'Kalkov' },
  { name: 'Marta', surname: 'Kostova' },
  { name: 'Georgi', surname: 'Tapalilov'},
  { name: 'Radoslav', surname: 'Georgiev'},
  { name: 'Rei', surname: 'Kagetsuki'}
]

say 'Creating predefined teachers...'.yellow

teachers.each do |teacher|
  Gaku::Teacher.where(teacher).first_or_create!
end


say "Creating #{@count[:teachers]} teachers...".yellow

batch_create(@count[:teachers]) do
  teacher = Gaku::Teacher.where(random_person).first_or_create!

  teacher.addresses.where(random_address).first_or_create!
  teacher.addresses.where(random_address).first_or_create!

  teacher.contacts.where(random_mobile_phone).first_or_create!
  teacher.contacts.where(random_home_phone).first_or_create!
  teacher.contacts.where(random_email).first_or_create!

  teacher.notes.where(random_note).first_or_create!
end
