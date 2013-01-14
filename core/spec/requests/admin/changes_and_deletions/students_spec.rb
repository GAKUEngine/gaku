require 'spec_helper'

describe 'Student Changes' do

  let!(:student) { create(:student) }

  it 'saves edits' do
    student.update_attributes(:name => "Changed name", :surname => "Changed surname",
                              :middle_name => "Changed middle_name",
                              :student_id_number => "Changed student_id_number",
                              :student_foreign_id_number => "Changed student_foreign_id_number",
                              :scholarship_status_id => 777,
                              :commute_method_id => 888,
                              :enrollment_status_id => 999)

    visit gaku.admin_changes_students_path
    page.should have_content "Changed name"
    page.should have_content "Changed surname"
    page.should have_content "Changed middle_name"
    page.should have_content "Changed student_id_number"
    page.should have_content "Changed student_foreign_id_number"
    page.should have_content "777"
    page.should have_content "888"
    page.should have_content "999"
  end

  it 'saves soft deletes' do
    student.update_attribute(:is_deleted, true)
    visit gaku.admin_changes_students_path
    page.should have_content "true"
    page.should have_content "false"
    page.should have_content "is_deleted"
    page.should have_content "update"
  end


end
