require 'spec_helper'

describe 'Students', type: :feature do

  before(:all) do
    Capybara.javascript_driver = :selenium
    set_resource 'student'
  end

  let!(:preset) { create(:preset, chooser_fields: { show_name: '1', show_surname: '1' }) }

  let(:class_group) { create(:class_group) }
  let(:active_semester) { create(:active_semester) }
  let(:semester_connector) do
    create(:semester_connector_class_group, semester: active_semester, semesterable: class_group)
  end
  let(:cl) { create(:active_semester, )}
  let(:enrollment_status_applicant) { create(:enrollment_status_applicant) }
  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:enrollment_status) { create(:enrollment_status) }

  let(:enrollment_status_transferred) do
    create(:enrollment_status, code: 'transferred', name: 'Transferred', active: true)
  end

  let(:student) do
    create(:student, name: 'John', surname: 'Doe', enrollment_status_code: enrollment_status_admitted.code)
  end

  let(:student2) do
    create(:student, name: 'Susumu', surname: 'Yokota', enrollment_status_code: enrollment_status_admitted.code)
  end

  let(:student3) do
    create(:student, name: 'Johny', surname: 'Bravo', enrollment_status_code: enrollment_status_admitted.code)
  end

  let(:student4) do
    create(:student, name: 'Felix', surname: 'Baumgartner', enrollment_status_code: enrollment_status_applicant.code)
  end

  let(:student5) do
    create(:student, name: 'Mike', surname: 'Tyson', enrollment_status_code: enrollment_status_transferred.code)
  end

  before do
    as :admin
    # preset
  end

  context 'existing' do
    before do
      enrollment_status
      enrollment_status_applicant
      enrollment_status_admitted
      student
      student2
      student3
      student4
      student5
      visit gaku.students_path
    end

    it 'lists' do
      # list show only students with active enrollment statuses
      size_of(table_rows).should eq 5
      page.has_text? "#{student.name}"
      page.has_text? "#{student.surname}"
      page.has_no_text? "#{student4.name}"
      page.has_no_text? "#{student4.surname}"
    end

    it 'chooses students', js: true do
      find(:css, "input#student-#{student.id}").set(true)
      page.has_selector? '#students-checked-div'

      within('#students-checked-div') do
        page.has_text? 'Chosen students(1)'
        # within('.show-chosen-table') { page.has_text? 'Show'}
        # click_link 'Show'
        wait_for_ajax

        page.has_selector? '#chosen-table'
        page.has_text? "#{student.name}"
        page.has_button? 'Enroll to class'
        page.has_button? 'Enroll to course'

        # within('.hide-chosen-table') do
        #   page.has_content? 'Hide'
        #   click_link 'Hide'
        # end

        wait_for_ajax
        page.has_no_selector? '#chosen-table'
      end
    end

    it 'searches by enrollment_status', js: true do
      click '#student-advanced-search-link'
      size_of(table_rows).should eq 5
      count? '4'

      select 'Transferred', from: 'q_enrollment_status_code_eq'
      wait_for_ajax

      size_of(table_rows).should eq 2
      within(count_div) { page.has_content? '1' }
      page.has_content? 'Mike'
      page.has_content? 'Tyson'

      select 'Admitted', from: 'q_enrollment_status_code_eq'
      wait_for_ajax

      size_of(table_rows).should eq 4
      within(count_div) { page.has_content? '3' }
      page.has_content? 'Mike'
      page.has_content? 'Tyson'
    end

    it 'has autocomplete while searching', js: true do
      click '#student-advanced-search-link'
      size_of(table_rows).should eq 5

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

      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::Student, :count).by(-1)

      within(count_div) { page.should_not have_content 'Students list(#{student_count - 1})' }
      current_path.should eq gaku.students_path
    end

  end

  context 'new', js: true do
    before do
      class_group
      active_semester
      semester_connector
      visit gaku.students_path
      click new_link
      expect(current_path).to eq gaku.new_student_path
    end

    it 'creates and shows with class_group' do
      expect do
        expect do
          select class_group.name, from: 'student_enrollments_enrollmentable_id'
          fill_in 'student_name', with: 'John'
          fill_in 'student_surname', with: 'Doe'
          click_button 'submit-student-button'
          flash_created?

        end.to change(Gaku::Student, :count).by 1
      end.to change(Gaku::Enrollment, :count).by 1

      expect(current_path).to eq gaku.edit_student_path(Gaku::Student.last)
      page.has_text? 'John'
      within('.class-groups-count') { has_content?('1') }
      click '#student-class-groups-menu a'
      has_content? class_group.name



      expect(Gaku::Student.last.class_groups).to eq [class_group]
    end

    it 'creates and shows' do
      expect do
        fill_in 'student_name', with: 'John'
        fill_in 'student_surname', with: 'Doe'
        click_button 'submit-student-button'
        flash_created?
      end.to change(Gaku::Student, :count).by 1
      expect(current_path).to eq gaku.edit_student_path(Gaku::Student.last)
      page.has_text? 'John'

    end

    it 'has enrollment_status_code set to enrolled' do
      expect(find('#student_enrollment_status_code').value).to eq 'enrolled'
    end

    context 'there is existing student' do

      it 'prefills enrollment_status, admitted and class_group with last student ones' do
        student = create(:student, enrollment_status_code: enrollment_status_applicant.code, admitted: '2013-01-19')
        create(:class_group_enrollment, enrollmentable: class_group, student: student)
        visit gaku.new_student_path

        expect(find('#student_enrollment_status_code').value).to eq 'applicant'
        expect(find('#student_admitted').value).to eq '2013-01-19'
        expect(find('#student_enrollments_enrollmentable_id').value).to eq class_group.id.to_s

        fill_in 'student_name', with: 'John'
        fill_in 'student_surname', with: 'Doe'
        click_button 'submit-student-button'
        flash_created?

        expect(current_path).to eq gaku.edit_student_path(Gaku::Student.last)
        expect(find('#student_enrollment_status_code').value).to eq 'applicant'
        expect(find('#student_admitted').value).to eq '2013-01-19'

        created_student = Gaku::Student.last
        expect(created_student.enrollment_status_code).to eq 'applicant'
        expect(created_student.admitted.to_s).to eq '2013-01-19'
        expect(created_student.class_groups.last).to eq class_group
      end
    end

    it 'prefills enrollment_status code' do
      expect(find('#student_enrollment_status_code').value).to eq 'enrolled'
      fill_in 'student_name', with: 'John'
      fill_in 'student_surname', with: 'Doe'
      click_button 'submit-student-button'
      flash_created?
      expect(current_path).to eq gaku.edit_student_path(Gaku::Student.last)
      expect(find('#student_enrollment_status_code').value).to eq 'enrolled'

      created_student = Gaku::Student.last
      expect(created_student.enrollment_status_code).to eq 'enrolled'
    end

    it { has_validations? }
  end

end
