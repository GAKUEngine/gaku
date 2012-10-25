require 'spec_helper'

describe "CourseEnrollment", :js => true  do
  stub_authorization!

  before :all do
    Helpers::Request.resource("course-class-group") 
  end


  before do
    @course = create(:course)
    visit course_path(@course)
  end

  it 'errors if no class_group is selected' do
    
    click new_link
    
    wait_until_visible form
    click submit
    page.should have_content('No Class Group selected')
  end

  it 'errors if selected class group is empty' do
    class_group = create(:class_group, :name => "Math")
    visit course_path(@course)

    click new_link
    
    wait_until_visible(form)
    wait_until_invisible(new_link)
    click_on 'Choose Class Group' 

    wait_until { page.has_content?('Math') }
    click "li:contains('Math')"
    click submit

    page.should have_content('Selected Class Group is empty')
  end

  it 'cancels enrolling a class group' do 
    click new_link
    wait_until_visible form
    ensure_cancel_creating_is_working 
  end

  context 'class group with 2 students' do

    before do
      class_group = create(:class_group, :name => "Math")
      @student1 = create(:student, :name => "Johniew", :surname => "Doe", :class_group_ids => [class_group.id])
      @student2 = create(:student, :name => "Amon", :surname => "Tobin", :class_group_ids => [class_group.id])

      visit course_path(@course)
    end

    it "enrolls a class group", :js => true do 
  
      expect do
        click new_link
      
        wait_until_visible(form)
        wait_until_invisible(new_link)
        click_on 'Choose Class Group' 

        wait_until { page.has_content?('Math') }
        click "li:contains('Math')"
        click submit

        wait_until_invisible(form)
        wait_until_visible(new_link)  
      end.to change(@course.students, :count).by 2
      
      page.should have_content("Johniew")
      page.should have_content("Amon")
      page.should have_content("View Assignments")
      page.should have_content("View Exams")
      # TODO show flash msgs for successfuly added students
    end

    it 'errors if all students are already added' do

      @course.students<<@student1
      @course.students<<@student2
      visit course_path(@course)

      click new_link
      
      wait_until_visible(form)
      wait_until_invisible(new_link)
      click_on 'Choose Class Group' 

      wait_until { page.has_content?('Math') }
      click "li:contains('Math')"
      click submit

      page.should have_content('All students are already added to the course')
    end
  
  end
end