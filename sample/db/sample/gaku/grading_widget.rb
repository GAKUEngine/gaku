# encoding: utf-8

syllabus = Gaku::Syllabus.create(:name => "Ruby", :code => "rb")
course = Gaku::Course.create(:code => "Fall 2011")

student = Gaku::Student.create(:name => 'Susumu', :surname => 'Yokota')

exam = Gaku::Exam.create(:name => "Midterm", :use_weighting => true, :weight => 4)
exam_portion_1 = exam.exam_portions.create(:name => 'Multiple Choice', :max_score => 100)
exam_portion_2 = exam.exam_portions.create(:name => 'Practical', :max_score => 200)
syllabus.exams << exam

exam = Gaku::Exam.create(:name => "Final", :use_weighting => true, :weight => 6)
exam_portion_1 = exam.exam_portions.create(:name => 'Question and Answer', :max_score => 200)
exam_portion_2 = exam.exam_portions.create(:name => 'Practical', :max_score => 300)
syllabus.exams << exam

course.students << student

syllabus.courses << course
