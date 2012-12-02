require 'spec_helper'

describe 'Students' do

  stub_authorization!

  let(:student) { create(:student, :name => 'John', :surname => 'Doe') }
  let(:student2) { create(:student, :name => 'Susumu', :surname => 'Yokota') }
  let(:student3) { create(:student, :name => 'Johny', :surname => 'Bravo') }
  let(:class_group) { create(:class_group, :name => 'Biology') }

  before :all do
    set_resource "student"
  end

  context "existing" do
    before do
      student
      student2
      student3
      visit gaku.students_path
    end

    it "lists" do
      size_of(table_rows).should eq 4
      page.should have_content "#{student.name}"
      page.should have_content "#{student.surname}"
      page.should have_content "#{student2.name}"
      page.should have_content "#{student2.surname}"
      page.should have_content "#{student3.name}"
      page.should have_content "#{student3.surname}"
    end

    it 'chooses students', :js => true do
      find(:css, "input#student-#{student.id}").set(true)
      wait_until_visible '#students-checked-div'

      within('#students-checked-div') do
        page.should have_content 'Chosen students(1)'
        click_link 'Show'
        wait_until_visible '#chosen-table'
        page.should have_content "#{student.name}"
        page.should have_button 'Enroll to class'
        page.should have_button 'Enroll to course'
        click_link 'Hide'
        wait_until_invisible '#chosen-table'
      end
    end

    it "has autocomplete while searching", :js => true do
      size_of(table_rows).should eq 4

      fill_in 'q_name_cont', :with => "J"
      wait_for_ajax

      size_of(table_rows).should eq 3
      within(table) do
        page.should have_content "John"
        page.should have_content "Johny"
      end

      fill_in 'q_surname_cont', :with => "B"
      wait_for_ajax

      size_of(table_rows).should eq 2
      within(table) do
        page.should have_content "Johny"
        page.should have_content "Bravo"
      end
    end

    context '#edit from show view', :js => true do
      before do
        visit gaku.student_path(student)
        click edit_link
        wait_until_visible modal
      end

      it "edits " do
        fill_in "student_surname", :with => "Kostova"
        fill_in "student_name",    :with => "Marta"
        click submit
        wait_until_invisible modal

        page.should have_content "Kostova"
        page.should have_content "Marta"
        student.reload
        student.name.should eq "Marta"
        student.surname.should eq "Kostova"
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end

    end

    context '#edit from index view', :js => true do
      before do
        visit gaku.students_path
        click edit_link
        wait_until_visible modal
      end

      it "edits" do
        fill_in "student_surname", :with => "Kostova"
        fill_in "student_name",    :with => "Marta"
        click submit
        wait_until_invisible modal

        page.should have_content "Kostova"
        page.should have_content "Marta"
        student.reload
        student.name.should eq "Marta"
        student.surname.should eq "Kostova"
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      visit gaku.student_path(student2)
      student_count = Gaku::Student.count
      page.should have_content "#{student2.name}"

      expect do
        click '#delete-student-link'
        within(modal) { click_on "Delete" }
        accept_alert
        wait_until { flash_destroyed? }
      end.to change(Gaku::Student, :count).by -1

      page.should_not have_content "#{student2.name}"
      within(count_div) { page.should_not have_content 'Students list(#{student_count - 1})' }
      current_path.should eq gaku.students_path
    end

    it 'enrolls to class', :js => true do
      class_group
      visit gaku.student_path(student)

      expect do
        click_on 'enroll-student-link'
        wait_until_visible modal

        select 'Biology', :from => 'class_group_enrollment_class_group_id'
        fill_in 'class_group_enrollment_seat_number', :with => '77'
        click_on "Create Class Enrollment"
        click_on 'Cancel'
        wait_until_invisible modal
      end.to change(Gaku::ClassGroupEnrollment, :count).by 1

      click_on 'enroll-student-link'
      wait_until_visible '#new-class-group-enrollment-modal'
      within('#new-class-group-enrollment-modal') do
        page.should have_content 'Biology'
        page.should have_content '77'
      end

      visit gaku.student_path(student)
      within('td#student-class-group-enrollment') do
        page.should have_content 'Biology'
        page.should have_content '77'
      end
    end

  end

  context "new", :js => true do
    before do
      visit gaku.students_path
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do
      expect do
        fill_in "student_name", :with => "John"
        fill_in "student_surname", :with => "Doe"
        click_button "submit-student-button"
        wait_until_invisible form
      end.to change(Gaku::Student, :count).by 1

      page.should have_content "John"
      within(count_div) { page.should have_content 'Students list(1)' }
      flash_created?
    end

    pending 'errors without required fields' do
      click submit
      wait_until do
        page.should have_content "can't be blank"
      end
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

end
