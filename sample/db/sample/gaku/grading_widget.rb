# encoding: utf-8

syllabus = Gaku::Syllabus.where(:name => "Ruby", :code => "rb").first_or_create!
course = Gaku::Course.where(:code => "Fall 2011").first_or_create!
enrollment_status = Gaku::EnrollmentStatus.find_by_code("admitted");
student = Gaku::Student.where(:name => 'Susumu', :surname => 'Yokota').first_or_create!

exam1 = Gaku::Exam.where(:name => "Midterm", :use_weighting => true, :weight => 4).first_or_create!
exam1_portion1 = exam1.exam_portions.where(:name => 'Multiple Choice', :max_score => 100).first_or_create!
exam1_portion2 = exam1.exam_portions.where(:name => 'Practical', :max_score => 200).first_or_create!

exam2 = Gaku::Exam.where(:name => "Final", :use_weighting => true, :weight => 6).first_or_create!
exam2_portion1 = exam2.exam_portions.where(:name => 'Question and Answer', :max_score => 200).first_or_create!
exam2_portion2 = exam2.exam_portions.where(:name => 'Practical', :max_score => 300).first_or_create!

exams = [exam1, exam2]

unless syllabus.exams.count > 0
  syllabus.exams << exams
end

unless course.students.count > 0
  course.students << student
end

syllabus.courses << course

