require 'spec_helper'

describe "CourseExams"  do
  stub_authorization!

  let(:syllabus) { create(:syllabus) }
  let(:course) { create(:course) }
  let(:student) { create(:student) }
  let(:exam) { create(:exam, :name => 'Math') }

  before do   
    syllabus.exams << exam
    course.students << student
    syllabus.courses << course

    visit gaku.course_path(course)

    click_link 'Exams'
  end
  
  it "shows grading link" do
    click_link 'Grading'
    current_path.should eq "/courses/#{course.id}/exams/#{exam.id}/grading"
  end

  pending "shows all grading link" do
    click_link 'All Exams'
    #TODO check redirection
  end
end