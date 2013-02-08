require 'spec_helper'

describe 'Student Changes' do

  as_admin

  let!(:student) { create(:student) }
  let(:scholarship_status) { create(:scholarship_status) }
  let(:enrollment_status) { create(:enrollment_status_admitted) }
  let(:commute_method_type) { create(:commute_method_type) }
  let(:commute_method) { create(:commute_method, commute_method_type: commute_method_type) }

  it 'saves edits' do
    student.update_attributes(:name => "Changed name", :surname => "Changed surname",
                              :middle_name => "Changed middle_name",
                              :student_id_number => "Changed student_id_number",
                              :student_foreign_id_number => "Changed student_foreign_id_number",
                              :scholarship_status_id => scholarship_status.id,
                              :commute_method_id => commute_method.id,
                              :enrollment_status_id => enrollment_status.id)

    visit gaku.admin_changes_students_path
    page.should have_content "Changed name"
    page.should have_content "Changed surname"
    page.should have_content "Changed middle_name"
    page.should have_content "Changed student_id_number"
    page.should have_content "Changed student_foreign_id_number"
    page.should have_content scholarship_status
    page.should have_content commute_method
    page.should have_content enrollment_status
  end

  it 'saves soft deletes' do
    student.update_attribute(:is_deleted, true)
    visit gaku.admin_changes_students_path
    page.should have_content "true"
    page.should have_content "false"
    page.should have_content "is_deleted"
    page.should have_content "update"
  end

  it 'saves destroy' do
    student.destroy
    visit gaku.admin_changes_students_path
    page.should have_content 'destroy'
  end


end
