# encoding: utf-8
require 'shared_sample_data'

say "Creating #{@count[:disposals]} teachers ...".yellow

batch_create(@count[:disposals]) do
  student = Gaku::Teacher.where(random_person.merge(deleted: true)).first_or_create!
end
