require 'spec_helper'

describe "CourseEnrollment"  do
  
  stub_authorization!

  let(:course) { create(:course) }
  let(:class_group) { create(:class_group, :name => "Math") }
  let(:student1) { create(:student, :name => "Johniew", :surname => "Doe", :class_group_ids => [class_group.id]) }
  let(:student2) { create(:student, :name => "Amon", :surname => "Tobin", :class_group_ids => [class_group.id]) }

  before :all do
    set_resource "course-class-group"
  end

  context 'no existing class group', :js => true do 
    before do 
      visit gaku.course_path(course)
      click new_link
      wait_until_visible submit
    end

    it 'errors if no class_group is selected' do
      click submit
      page.should have_content 'No Class Group selected'
    end

    it 'cancels enrolling' do 
      ensure_cancel_creating_is_working 
    end
  end

  context 'empty class group', :js => true do 
    it 'errors if class group is empty' do
      class_group
      visit gaku.course_path(course)

      click new_link
      
      wait_until_visible(submit)
      select 'Math', :from => 'course_class_group_id'
      click submit

      page.should have_content 'Selected Class Group is empty'
    end
  end

  context 'class group with 2 students', :js => true do
    before do
      class_group
      student1
      student2
      visit gaku.course_path(course)
    end

    it "enrolls a class group" do 
        click new_link
        wait_until_visible(submit)
  
      expect do
        select 'Math', :from => 'course_class_group_id'
        click submit
        wait_until_invisible(form) 
      end.to change(course.students, :count).by 2
      
      page.should have_content "Johniew"
      page.should have_content "Amon"
      page.should have_content "View Assignments"
      page.should have_content "View Exams"
      # TODO show flash msgs for successfuly added students
    end

    it 'errors if all students are already added' do
      course.students << student1
      course.students << student2
      visit gaku.course_path(course)

      click new_link
      
      wait_until_visible(form)
      wait_until_invisible(new_link)
      select 'Math', :from => 'course_class_group_id'
      click submit

      page.should have_content 'All students are already added to the course'
    end
  
  end
end