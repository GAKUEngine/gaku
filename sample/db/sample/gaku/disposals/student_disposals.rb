# encoding: utf-8
require 'shared_sample_data'

say "Creating #{@count[:disposals]} students and guardians ...".yellow

batch_create(@count[:disposals]) do
  student = Gaku::Student.where(random_person.merge(deleted: true)).first_or_create!
  guardian = Gaku::Guardian.where(random_person.merge(deleted: true)).first_or_create!
  student.guardians << guardian
end
