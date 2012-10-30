@course = Gaku::Course.create(:code => "fall2011")
@student = Gaku::Student.create(:name => 'Susumu', :surname => 'Yokota')
@exam_portion = Gaku::ExamPortion.create(:name => 'First Portion', :max_score => 100)
@exam = Gaku::Exam.new(:name => "Ruby Exam", :use_weighting => true, :weight => 5) 
@exam.exam_portions << @exam_portion
@exam.save

@syllabus = Gaku::Syllabus.create(:name => "Ruby", :code => "rb")

@syllabus.exams << @exam
@course.students << @student

@syllabus.courses << @course