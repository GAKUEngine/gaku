require 'spec_helper'

describe 'Student Addresses Changes' do

  let!(:student) { create(:student) }
  let!(:address) { create(:address, :city => "Nagoya", :address1 => "Subaru str.") }
  let!(:student_address) { create(:student_address, :student => student, :address => address) }

  it 'saves edits' do
    address.update_attributes(:city => "Changed", :address1 => "Toyota str.")
    visit gaku.admin_changes_student_addresses_path
    page.should have_content "city"
    page.should have_content "address1"
    page.should have_content "update"
    page.should have_content "Nagoya"
    page.should have_content "Changed"
    page.should have_content "Subaru str."
    page.should have_content "Toyota str."
  end

  it 'saves soft deletes' do
    address.update_attribute(:is_deleted, true)
    visit gaku.admin_changes_student_addresses_path
    page.should have_content "true"
    page.should have_content "false"
    page.should have_content "is_deleted"
    page.should have_content "update"
  end

end
