require 'spec_helper'

describe 'Student Contact Changes' do

  as_admin

  before do
    @student = create(:student_with_one_contact)
    @student.reload
    @contact = @student.contacts.first
  end

  it 'saves edits' do
    old_data = @contact.data
    @contact.update_attributes(:data => "123456789")
    visit gaku.admin_changes_student_contacts_path
    page.should have_content old_data
    page.should have_content "update"
    page.should have_content "123456789"
  end

  it 'saves destroy' do
    @contact.destroy
    visit gaku.admin_changes_student_contacts_path
    page.should have_content "destroy"
  end

end
