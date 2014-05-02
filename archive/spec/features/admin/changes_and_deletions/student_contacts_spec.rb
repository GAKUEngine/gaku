require 'spec_helper'

describe 'Student Contact Changes' do

  before { as :admin }

  before do
    @student = create(:student, :with_contact)
    @student.reload
    @contact = @student.contacts.first
  end

  it 'saves edits', type: 'contact', versioning: true do
    old_data = @contact.data
    Gaku::ContactUpdation.new(@contact).update(data: '123456789')
    visit gaku.admin_changes_student_contacts_path
    page.should have_content old_data
    page.should have_content 'update'
    page.should have_content '123456789'
  end

  it 'saves destroy', type: 'contact', versioning: true do
    @contact.destroy
    visit gaku.admin_changes_student_contacts_path
    page.should have_content 'destroy'
  end

end
