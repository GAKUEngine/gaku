require 'spec_helper'

describe 'Student Guardians' do

  before(:all) { set_resource 'student-guardian' }
  before { as :admin }

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }

  context 'existing' do
    before do
      student.guardians << guardian
      visit gaku.edit_student_guardian_path(student, guardian)
    end

    it 'soft deletes', js: true do
      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::Guardian, :count).by(-1)

      current_path.should eq gaku.edit_student_path(student)
      click '#student-guardians-menu a'
      # within('.guardians-count')  { expect(page.has_content?('0')).to eq true }
      within(count_div) { has_no_content? 'Guardians list(1)' }
    end
  end

end
