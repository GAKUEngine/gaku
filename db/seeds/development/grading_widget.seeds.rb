@course = Course.create(:code => "fall2011")
@student = Student.create(:name => 'Susumu', :surname => 'Yokota')
@exam_portion = ExamPortion.create(:name => 'First Portion')
@exam = Exam.new(:name => "Ruby Exam") 
@exam.exam_portions << @exam_portion
@exam.save

@syllabus = Syllabus.create(:name => "Ruby")

@syllabus.exams << @exam
@course.students << @student

@syllabus.courses << @course
@syllabus.save