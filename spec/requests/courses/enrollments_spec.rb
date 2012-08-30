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
    sleep 5 
    visit course_path(@course)
    sleep 5
    click_link 'add_student_enrollment'
    wait_until { page.has_content?('Choose Student') } 
    select "John Doe", :from => 'course_enrollment_student_id'
    click_button "Enroll Student"

    page.should have_content("John")
    sleep 1
    @course.course_enrollments.size.should == 1     
    page.should have_content("View Assignments")#check if the student is added to the table visually without redirect
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
    sleep 1
    @course.course_enrollments.size.should == 1
  end

  it "should enroll a class group", :js => true do 
    class_group = Factory(:class_group, :name => "Math")
    student1 = Factory(:student, :name => "Johniew", :surname => "Doe", :class_group_ids => [class_group.id])
    student2 = Factory(:student, :name => "Amon", :surname => "Tobin", :class_group_ids => [class_group.id])
    
    visit course_path(@course)

    click_on 'add_class_group_enrollment'
    click_on 'Choose Class Group' 
    wait_until { page.has_content?('Math') }
    find("li:contains('Math')").click
    click_button "Enroll Class Group"

    page.should have_content("Johniew")
    page.should have_content("Amon")
    sleep 1
    @course.course_enrollments.size.should == 2
    
    page.should have_content("View Assignments")#check if the students are added to the table visually without redirect
  end

end