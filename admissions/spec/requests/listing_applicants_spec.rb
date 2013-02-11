require 'spec_helper'

describe 'Admin Listing Applicants' do

  stub_authorization!

  let!(:attendance) { create(:attendance) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }
  let!(:student) { create(:student, enrollment_status_id:enrollment_status_applicant.id, is_deleted:false, admitted:false) }

  context 'lists applicants and', js:true do

    before do
      @admission = create(:admission, 
                          student_id: student.id)
      student.admission = @admission
      student.save!
      visit gaku.admin_admissions_path

      page.should have_content 'Applicants List'
      click_on 'Applicants List'
      current_path.should == "/admin/admissions/listing_applicants"
    end

    it 'edits applicants' do
      click '.edit-link'
      wait_until_visible modal
      fill_in 'student_name', with: 'Martina'
      click_on 'Save Student'
      wait_until_invisible modal
      page.should have_content 'Martina'
      visit gaku.listing_applicants_admin_admissions_path
      page.should have_content 'Martina'
    end

    it 'shows applicants' do
      click '.show-link'
      current_path.should eq "admin/students/1"
      page.should have_content "#{student.name}"
    end

    it 'returns to admissions' do
      page.should have_content 'Admissions'
      click_on 'Admissions'
      current_path.should eq "/admin/admissions"
      page.should have_content 'Admission Candidates List'
      page.should have_content "#{student.name}"
    end

    it 'goes to admissions list' do
      page.should have_content 'Listing Admissions'
      click_on 'Listing Admissions'
      current_path.should eq "/admin/admissions/listing_admissions"
      page.should have_content 'Admission Candidates List'
      page.should have_content "#{student.name}"
    end

    it 'deletes applicant' do
    end
  end
end