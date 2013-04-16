require 'spec_helper'

describe "CourseExams", :js => true  do

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

    click '#course-exam-link'
  end

  it "shows grading link" do
    click '.grading_link'
    current_path.should eq gaku.grading_course_exam_path(course, exam)
  end

  it "shows all grading link" do
    page.should have_content 'All Exams'
    click '#all-course-exams-grade'
    current_path.should eq gaku.grading_course_exams_path(course)
  end
end
