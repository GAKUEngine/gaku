require 'spec_helper'

describe 'Student Guardians' do

  before { as :admin }

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }

  before :all do
    set_resource 'student-guardian'
  end

  context 'new', js: true do
    before do
      visit gaku.edit_student_path(student)
      click tab_link
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        #required
        fill_in 'guardian_surname',         with: 'Doe'
        fill_in 'guardian_name',            with: 'John'

        fill_in 'guardian_surname_reading', with: 'Phonetic Doe'
        fill_in 'guardian_name_reading',    with: 'Phonetic John'
        fill_in 'guardian_relationship',    with: 'Father'

        click submit
        wait_until_invisible form
      end.to change(student.guardians, :count).by 1

      #required
      page.should have_content 'Doe'
      page.should have_content 'John'

      page.should have_content 'Father'
      within(count_div) { page.should have_content 'Guardians list(1)' }
      within(tab_link)  { page.should have_content 'Guardians(1)' }
      flash_created?
    end
  end

  context 'existing' do
    before(:each) do
      student.guardians << guardian

      visit gaku.edit_student_path(student)
      click tab_link
    end

    context 'edit', js: true do
      before do
        visit gaku.edit_student_guardian_path(student, guardian)
      end

      it 'edits' do
        fill_in 'guardian_name',    with: 'Edited guardian name'
        fill_in 'guardian_surname', with: 'Edited guardian surname'
        click submit

        page.should have_content 'Edited guardian name'
        page.should have_content 'Edited guardian surname'
        flash_updated?
      end
    end

    it 'deletes', js: true do
      page.should have_content guardian.name
      within(count_div) { page.should have_content 'Guardians list(1)' }
      within(tab_link)  { page.should have_content 'Guardians(1)' }

      expect do
        click '.delete-student-guardian-link'
        accept_alert
        within('#student-guardians') { page.should_not have_content guardian.name }
      end.to change(student.guardians, :count).by -1

      within(count_div) { page.should_not have_content 'Guardians list(1)' }
      within(tab_link)  { page.should_not have_content 'Guardians(1)' }
      page.should_not have_content guardian.name
      flash_destroyed?
    end
  end

end
