require 'shared_sample_data'

say "Creating #{@count[:disposals]} exam attachment disposals ...".yellow

puts File.join(File.dirname(__FILE__), '..', 'images', '120x120.jpg')

batch_create(@count[:disposals]) do
  exam = Gaku::Exam.where(name: "#{Faker::Education.major} Exam").first_or_create!
  exam_portion = exam.exam_portions.where(name: "#{Faker::Education.major} ExamPortion", max_score: 100).first_or_create!
  Gaku::Attachment.create!(name: 'Attachment Name', attachable: exam_portion, asset: File.open(File.join(File.dirname(__FILE__), '..', 'images', '120x120.jpg')), deleted: true)
end
