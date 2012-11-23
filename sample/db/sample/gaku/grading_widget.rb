# encoding: utf-8

syllabus = Gaku::Syllabus.create(:name => "Ruby", :code => "rb")
course = Gaku::Course.create(:code => "Fall 2011")

student = Gaku::Student.create(:name => 'Susumu', :surname => 'Yokota')

exam = Gaku::Exam.new(:name => "Midterm", :use_weighting => true, :weight => 4) 
exam_portion_1 = Gaku::ExamPortion.create(:name => 'Multiple Choice', :max_score => 100)
exam_portion_2 = Gaku::ExamPortion.create(:name => 'Practical', :max_score => 200)
exam.exam_portions << exam_portion_1
exam.exam_portions << exam_portion_2
exam.save
syllabus.exams << exam

exam = Gaku::Exam.new(:name => "Final", :use_weighting => true, :weight => 6) 
exam_portion_1 = Gaku::ExamPortion.create(:name => 'Question and Answer', :max_score => 200)
exam_portion_2 = Gaku::ExamPortion.create(:name => 'Practical', :max_score => 300)
exam.exam_portions << exam_portion_1
exam.exam_portions << exam_portion_2
exam.save
syllabus.exams << exam

course.students << student

syllabus.courses << course
