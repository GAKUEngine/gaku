# encoding: utf-8
require 'shared_sample_data'

say "Creating #{@count[:disposals]} course groups ...".yellow

batch_create(@count[:disposals]) do
  Gaku::CourseGroup.where(name: "#{Faker::Education.major} CourseGroup", deleted: true).first_or_create!
end