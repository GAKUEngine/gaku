require 'spec_helper'

describe 'Student External School Records' do

  before { as :admin }

  let!(:student) { create(:student) }
  let!(:school) { create(:school) }

  before(:all) { set_resource 'student-external-school-record' }

  context 'new', js: true do
    before do
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click tab_link
      click new_link
    end

    it 'creates' do
      expect do
        select school.name, from: 'external_school_record_school_id'
        click submit
        flash_created?
      end.to change(Gaku::ExternalSchoolRecord, :count).by(1)
    end

  end


  context 'existing', js: true do

    let!(:external_school_record) { create(:external_school_record, school: school, student: student) }

    context 'remove' do

      before do
        visit gaku.edit_student_path(student)
        click '#student-academic-tab-link'
        click tab_link
      end

      it 'deletes' do
        expect do
          ensure_delete_is_working
          flash_destroyed?
        end.to change(Gaku::ExternalSchoolRecord, :count).by(-1)
      end
    end

  end

end
