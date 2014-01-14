require 'spec_helper'

describe 'Student Changes' do

  before { as :admin }

  let!(:student) { create(:student) }
  let(:scholarship_status) { create(:scholarship_status) }
  let(:enrollment_status) { create(:enrollment_status) }
  let(:commute_method_type) { create(:commute_method_type) }

  it 'saves edits', versioning: true do
    student.update_attributes(name: 'Changed name', surname: 'Changed surname',
                              middle_name: 'Changed middle_name',
                              foreign_id_code: 'Changed foreign_id_code',
                              scholarship_status_id: scholarship_status.id,
                              commute_method_type_id: commute_method_type.id,
                              enrollment_status_code: enrollment_status.code)

    visit gaku.admin_changes_students_path
    page.should have_content 'Changed name'
    page.should have_content 'Changed surname'
    page.should have_content 'Changed middle_name'
    page.should have_content 'Changed foreign_id_code'
    page.should have_content scholarship_status
    page.should have_content commute_method_type
    page.should have_content enrollment_status
  end

  it 'saves soft deletes', versioning: true do
    student.update_attribute(:deleted, true)
    visit gaku.admin_changes_students_path
    page.should have_content 'true'
    page.should have_content 'false'
    page.should have_content 'deleted'
    page.should have_content 'update'
  end

  it 'saves destroy', versioning: true do
    student.destroy
    visit gaku.admin_changes_students_path
    page.should have_content 'destroy'
  end

end
