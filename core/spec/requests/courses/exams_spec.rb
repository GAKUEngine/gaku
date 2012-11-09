require 'spec_helper'

describe "CourseExams", :js => true  do
  stub_authorization!

  before do
    @syllabus = create(:syllabus) 
    @course = create(:course)
    @student = create(:student)
    @exam = create(:exam, :name => 'Math')
    @syllabus.exams << @exam
    @course.students << @student
    @syllabus.courses << @course

    @course.students.size.should eq 1 
    @syllabus.courses.size.should eq 1
    @syllabus.exams.size.should eq 1

    visit gaku.course_path(@course)

    click_link 'Exams'
    
  end
  
  it "shows grading link" do
    click_link 'Grading'
    #TODO check redirection
  end

  it "shows all grading link" do
    click_link 'All Exams'
    #TODO check redirection
  end
end