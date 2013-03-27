require 'spec_helper'

describe 'Admin Disposals Student Addresses' do

  as_admin

  let(:student) { create(:student_with_one_address) }

  before do
    student
    student.addresses.reload
  end

  it "no soft deleted student addresses", :js => true do
    visit gaku.student_addresses_admin_disposals_path
    within('#admin-student-addresses-disposals-index') do
      page.all('tbody tr').size.should eq 0
      page.should_not have_content(student.addresses.first.address1)
    end
  end

  context 'recover and destroy student address disposals', :js => true do
    before do
      visit gaku.edit_student_path(student)
      click '.delete-link'
      accept_alert

      page.should_not have_content(student.addresses.first.address1)
      flash_destroyed?

      visit gaku.student_addresses_admin_disposals_path
      page.should have_content(student.addresses.first.address1)

    end

    it 'recover' do
      click '.recovery-link'
      flash_recovered?

      visit gaku.edit_student_path(student)
      page.should have_content(student.addresses.first.address1)
    end

    it "delete" do
      click '.delete-link'
      accept_alert
      flash_destroyed?

      visit gaku.edit_student_path(student)
      page.should_not have_content(student.addresses.first.address1)
    end

  end

end