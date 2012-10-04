require 'spec_helper'

describe "CourseExams"  do
  stub_authorization!

  before do
    @syllabus = create(:syllabus) 
    @course = create(:course)
    @student = create(:student)
    @exam = create(:exam, :name => 'Math')
    @syllabus.exams << @exam
    @course.students << @student
    @syllabus.courses << @course
  end

  it "should show grading link", :js => true do
    visit course_path(@course)

    click_link 'Exams'
    @course.students.size.should eql(1) 
    @syllabus.courses.size.should eql(1)
    @syllabus.exams.size.should eql(1)
    click_link 'MathGrading'
  end

  it "should show all grading link", :js => true do
    visit course_path(@course)

    click_link 'Exams'
    @course.students.size.should eql(1) 
    @syllabus.courses.size.should eql(1)
    @syllabus.exams.size.should eql(1)
    click_link 'All Exams'
  end
end