# encoding: utf-8

names = [
  "Summer Program Entry",
  "Regular Program Entry",
  "International Program Exams",
  "National Information Engineer Certification"
]

names.each do |name|
  Gaku::Exam.create(:name => name)
end
