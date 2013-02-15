require 'spec_helper'

describe "CourseExams"  do

  as_admin

  let(:syllabus) { create(:syllabus) }
  let(:course) { create(:course) }
  let(:student) { create(:student) }
  let(:exam) { create(:exam, :name => 'Math') }
  let(:exam2) { create(:exam) }

  before do
    syllabus.exams << exam
    syllabus.exams << exam2
    course.students << student
    syllabus.courses << course

    visit gaku.course_path(course)

    click_link 'Exams'
  end

  it "shows grading link" do
    click_link 'Grading'
    current_path.should eq "/courses/#{course.id}/exams/#{exam.id}/grading"
  end

  it "shows all grading link" do
    page.should have_content 'All Exams'
    click_link 'All Exams'
    current_path.should eq "/courses/#{course.id}/exams/grading"
  end
end
