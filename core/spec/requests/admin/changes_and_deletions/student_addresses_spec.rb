require 'spec_helper'

describe 'Student Addresses Changes' do

  before do
    @student = create(:student_with_one_address)
    @student.reload
    @address = @student.addresses.first
  end

  it 'saves edits' do
    old_city = @address.city
    old_address1 = @address.address1
    @address.update_attributes(:city => "Changed city", :address1 => "Changed address1")
    visit gaku.admin_changes_student_addresses_path
    page.should have_content old_city
    page.should have_content old_address1
    page.should have_content "update"
    page.should have_content "Changed"
    page.should have_content "Changed address1"
  end

  it 'saves soft deletes' do
    @address.update_attribute(:is_deleted, true)
    visit gaku.admin_changes_student_addresses_path
    page.should have_content "true"
    page.should have_content "false"
    page.should have_content "is_deleted"
    page.should have_content "update"
  end

end
