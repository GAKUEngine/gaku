require 'spec_helper'

describe "CourseEnrollment"  do
  before do
    @course = Factory(:course)
    sign_in_as!(Factory(:user))
    within('ul#menu') { click_link "Course Management"}
    within('ul#menu') { click_link "Courses"}
  end

  it "should enroll and show student", :js => true do

    Factory(:student, :name => "John", :surname => "Doe")
    visit course_path(@course)

    click_link 'add_student_enrollment'
    wait_until { page.has_content?('Choose Student') } 
    select "John Doe", :from => 'course_enrollment_student_id'
    click_button "Enroll Student"

    page.should have_content("John")
    @course.course_enrollments.size.should == 1     
  end

  it "should enroll student only once for a course", :js => true  do
    Factory(:student, :id => "123", :name => "Toni", :surname => "Rtoe")
    Factory(:course_enrollment, :student_id => "123", :course_id => @course.id)
    visit course_path(@course)
    page.should have_content("Toni")

    click_link 'add_student_enrollment'
    wait_until { page.has_content?('Choose Student') } 

    select "Toni Rtoe", :from => 'course_enrollment_student_id'
    click_button "Enroll Student"
    page.should have_content ("Student Already enrolled to course!")
    @course.course_enrollments.size.should == 1
  end

  it "should enroll a class group", :js => true do 
    class_group = Factory(:class_group, :name => "Math")
    student1 = Factory(:student, :name => "John", :surname => "Doe")
    student2 = Factory(:student, :name => "Amon", :surname => "Tobin")
    Factory(:class_group_enrollment, :student => student1, :class_group => class_group)

    visit course_path(@course)

    click_link 'add_class_group_enrollment'
    wait_until { page.has_content?('Choose Class Group') } 
    #sleep 5 
    #save_and_open_page
    select "Math", :from => 'course_class_group_id'
    click_button "Enroll Class Group"

    page.should have_content("John")
    #@course.course_enrollments.size.should == 1
  end

end