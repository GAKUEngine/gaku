require 'spec_helper'

describe "CourseEnrollment"  do

  as_admin

  let(:course) { create(:course) }
  let(:student1) { create(:student, :name => "John", :surname => "Doe") }

  before :all do
    set_resource "course-student"
  end

  context 'student', :js => true do

    before do
      student1
      visit gaku.course_path(course)
    end

    it "enrolls and shows" do
      click new_link
      wait_until_visible modal
      expect do
        enroll_one_student_via_button('Enroll to course')
      end.to change(Gaku::CourseEnrollment, :count).by 1

      within(table){
        page.should have_content("Doe John")
        page.should have_content("View Assignments")
        page.should have_content("View Exams")
      }

      size_of(table_rows).should == 2 #one for head
      within(count_div) { page.should have_content('Students list(1)') }
      within('#new-course-enrollment-tab-link') { page.should have_content('Students(1)') }
      page.should have_content('Successfully enrolled');
    end

    it "enrolls student only once"  do
      course.students << student1
      visit gaku.course_path(course)

      page.should have_content("#{student1.name}")
      course.students.size.should eq 1

      click new_link
      wait_until_visible modal
      within('tr#student-' + student1.id.to_s) do
        page.should have_selector("img.enrolled")
      end
    end

  end

end
