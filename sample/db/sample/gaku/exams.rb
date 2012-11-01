# encoding: utf-8

names = [ "Biology Exam", "Math Exam", "Literature Exam"]

names.each do |name|
  Gaku::Exam.create(:name => name)
end