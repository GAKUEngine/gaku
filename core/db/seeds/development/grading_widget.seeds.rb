@course = Course.create(:code => "fall2011")
@student = Student.create(:name => 'Susumu', :surname => 'Yokota')
@exam_portion = ExamPortion.create(:name => 'First Portion', :max_score => 100)
@exam = Exam.new(:name => "Ruby Exam", :use_weighting => true, :weight => 5) 
@exam.exam_portions << @exam_portion
@exam.save

@syllabus = Syllabus.create(:name => "Ruby", :code => "rb")

@syllabus.exams << @exam
@course.students << @student

@syllabus.courses << @course