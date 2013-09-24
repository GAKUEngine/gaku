# encoding: utf-8
require 'shared_sample_data'

say "Creating #{@count[:disposals]} exams ...".yellow

batch_create(@count[:disposals]) do
  Gaku::Exam.where(name: Faker::Education.major, deleted: true).first_or_create!
end
