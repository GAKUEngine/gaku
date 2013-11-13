require 'spec_helper'

describe 'Student Guardians' do

  before(:all) { set_resource 'student-guardian' }
  before { as :admin }

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }

  context 'new', js: true do
    before do
      visit gaku.edit_student_path(student)
      click tab_link
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        expect do
          fill_in 'guardian_surname',         with: 'Doe'
          fill_in 'guardian_name',            with: 'John'

          fill_in 'guardian_surname_reading', with: 'Phonetic Doe'
          fill_in 'guardian_name_reading',    with: 'Phonetic John'
          fill_in 'guardian_relationship',    with: 'Father'

          click submit
          flash_created?
        end.to change(Gaku::Guardian, :count).by(1)
      end.to change(student.guardians, :count).by(1)

      has_content? 'Doe'
      has_content? 'John'
      has_content? 'Father'

      count? 'Guardians list(1)'
      within(tab_link)  { has_content? 'Guardians(1)' }
    end
  end

  context 'existing' do
    before do
      student.guardians << guardian
      visit gaku.edit_student_guardian_path(student, guardian)
    end

    context 'edit', js: true do
      it 'edits' do
        fill_in 'guardian_name',    with: 'Edited guardian name'
        fill_in 'guardian_surname', with: 'Edited guardian surname'
        click submit
        flash_updated?

        expect(find_field('guardian_name').value).to eq 'Edited guardian name'
        expect(find_field('guardian_surname').value).to eq 'Edited guardian surname'
      end
    end


    it 'soft deletes', js: true do
      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        wait_until { flash_destroyed? }
      end.to change(Gaku::Guardian, :count).by(-1)

      current_path.should eq gaku.edit_student_path(student)
      click tab_link
      within(tab_link)  { has_no_content? 'Guardians(1)' }
      within(count_div) { has_no_content? 'Guardians list(1)' }
    end
  end

end
