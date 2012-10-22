require 'spec_helper'

describe 'Student CourseEnrollments' do
  stub_authorization!

  before :all do
    Helpers::Request.resource("student-course-enrollment") 
  end
  
  before do
    @student = create(:student)
    @course = create(:course, :code => 'fall2050')
    visit student_path(@student) 
  end

  context 'new', :js => true do 
    before do 
      click tab_link
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do
      expect do 
        select "fall2050", :from => 'course_enrollment_course_id'
        click submit
        wait_until_invisible form
      end.to change(@student.courses, :count).by 1

      page.should have_content "fall2050"
      within(count_div) { page.should have_content 'Courses list(1)' }
      within(tab_link)  { page.should have_content 'Courses(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working 
    end
  end

  it "deletes", :js => true do
    @student.courses << @course

    visit student_path(@student) 
    click tab_link

    within(count_div) { page.should have_content 'Courses list(1)' }
    within(tab_link)  { page.should have_content 'Courses(1)' }
    page.should have_content @course.code

    expect do 
      ensure_delete_is_working
    end.to change(@student.courses, :count).by -1

    within(count_div) { page.should_not have_content 'Courses list(1)' }
    within(tab_link)  { page.should_not have_content 'Courses(1)' }
    page.should_not have_content @course.code
    flash_destroyed?
  end
  
end