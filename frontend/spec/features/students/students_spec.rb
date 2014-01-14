require 'spec_helper'

describe 'Students', type: :feature do

  before(:all) do
    Capybara.javascript_driver = :selenium
    set_resource 'student'
  end
  before { as :admin }

  let(:class_group) { create(:class_group) }
  let(:enrollment_status_applicant) { create(:enrollment_status_applicant) }
  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:enrollment_status) { create(:enrollment_status) }
  let(:student) { create(:student, name: 'John', surname: 'Doe', enrollment_status_code: enrollment_status_admitted.code) }
  let(:student2) { create(:student, name: 'Susumu', surname: 'Yokota', enrollment_status_code: enrollment_status_admitted.code) }
  let(:student3) { create(:student, name: 'Johny', surname: 'Bravo', enrollment_status_code: enrollment_status_admitted.code) }
  let(:student4) { create(:student, name: 'Felix', surname: 'Baumgartner', enrollment_status_code: enrollment_status_applicant.code) }


  context 'existing' do
    before do
      enrollment_status
      enrollment_status_applicant
      enrollment_status_admitted
      student
      student2
      student3
      student4
      visit gaku.students_path
    end

    it 'lists' do
      #list show only students with active enrollment statuses
      size_of(table_rows).should eq 4
      page.has_text? "#{student.name}"
      page.has_text? "#{student.surname}"
      page.has_no_text? "#{student4.name}"
      page.has_no_text?  "#{student4.surname}"
    end

    it 'chooses students', js: true do
      find(:css, "input#student-#{student.id}").set(true)
      page.has_selector? '#students-checked-div'

      within('#students-checked-div') do
        page.has_text? 'Chosen students(1)'
        within('.show-chosen-table') { page.has_text? 'Show'}
        click_link 'Show'
        wait_for_ajax

        page.has_selector? '#chosen-table'
        page.has_text? "#{student.name}"
        page.has_button? 'Enroll to class'
        page.has_button? 'Enroll to course'

        within('.hide-chosen-table') do
          page.has_content? 'Hide'
          click_link 'Hide'
        end

        wait_for_ajax
        page.has_no_selector? '#chosen-table'
      end
    end

    it 'has autocomplete while searching', js: true do
      size_of(table_rows).should eq 4

      fill_in 'q_name_cont', with: 'J'
      wait_for_ajax

      size_of(table_rows).should eq 3
      within(table) do
        page.should have_content 'John'
        page.should have_content 'Johny'
      end

      fill_in 'q_surname_cont', with: 'B'
      wait_for_ajax

      size_of(table_rows).should eq 2
      within(table) do
        page.should have_content 'Johny'
        page.should have_content 'Bravo'
      end
    end


    it 'deletes', js: true do
      visit gaku.edit_student_path(student2)
      student_count = Gaku::Student.count

      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::Student, :count).by -1

      within(count_div) { page.should_not have_content 'Students list(#{student_count - 1})' }
      current_path.should eq gaku.students_path
    end

  end

  context 'new', js: true do
    before do
      class_group
            #page.driver.debug
      visit gaku.students_path
      click new_link
    end

    xit 'creates and shows with class_group' do
      expect do
        expect do
          select class_group.name, from: 'Class'
          fill_in 'student_name', with: 'John'
          fill_in 'student_surname', with: 'Doe'
          click_button 'submit-student-button'
          flash_created?
        end.to change(Gaku::Student, :count).by 1
      end.to change(Gaku::ClassGroupEnrollment, :count).by 1

      expect(Gaku::Student.last.class_groups).to eq [class_group]

      page.has_text? 'John'
      count? 'Students list(1)'
    end

    it 'creates and shows' do
      expect do
        fill_in 'student_name', with: 'John'
        fill_in 'student_surname', with: 'Doe'
        click_button 'submit-student-button'
        flash_created?
      end.to change(Gaku::Student, :count).by 1

      page.has_text? 'John'
      count? 'Students list(1)'
    end

    it { has_validations? }
  end

end
