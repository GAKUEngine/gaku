# encoding: utf-8
require 'shared_sample_data'

say "Creating #{@count[:disposals]} teachers with addresses and contacts ...".yellow

batch_create(@count[:disposals]) do
  teacher = Gaku::Teacher.where(random_person).first_or_create!
  teacher.addresses.where(random_address.merge(deleted: true)).first_or_create!
  teacher.contacts.where(random_home_phone.merge(deleted: true)).first_or_create!
end

say "Creating #{@count[:disposals]} students with addresses and contacts ...".yellow

batch_create(@count[:disposals]) do
  student = Gaku::Student.where(random_person).first_or_create!
  student.addresses.where(random_address.merge(deleted: true)).first_or_create!
  student.contacts.where(random_home_phone.merge(deleted: true)).first_or_create!
end

say "Creating #{@count[:disposals]} guardians with addresses and contacts ...".yellow

batch_create(@count[:disposals]) do
  guardian = Gaku::Guardian.where(random_person).first_or_create!
  guardian.addresses.where(random_address.merge(deleted: true)).first_or_create!
  guardian.contacts.where(random_home_phone.merge(deleted: true)).first_or_create!
end