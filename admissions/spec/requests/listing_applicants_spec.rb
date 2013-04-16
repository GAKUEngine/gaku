require 'spec_helper'

describe 'Admin Listing Applicants' do

  as_admin

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
      current_path.should eq "/admin/students/#{student.id}/edit"
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

    context 'deleting applicant' do

      before do
        click '.edit-link'
        click '#delete-student-link'
        within(modal) { click_on "Delete" }
        accept_alert
        flash_destroyed?
      end

      it 'soft deletes the applicant' do
        current_path.should == "/admin/admissions/listing_applicants"
        page.should_not have_content "#{student.name}"
        visit gaku.listing_applicants_admin_admissions_path
        page.should_not have_content "#{student.name}"
      end

      it 'shows the student in student disposals' do
        visit gaku.students_admin_disposals_path
        page.should have_content "#{student.name}"
      end

      it 'deletes student from students index' do
        visit gaku.students_path
        page.should_not have_content "#{student.name}"
      end

      it 'shows the deleted applicant' do
        visit gaku.students_admin_disposals_path
        page.should have_content "#{student.name}"
        click '.show-link'
        current_path.should == "/admin/students/#{student.id}"
      end

      it 'revert deleting' do
        visit gaku.students_admin_disposals_path
        page.should have_content "#{student.name}"
        click '.recovery-link'
        flash_recovered?
        visit gaku.listing_applicants_admin_admissions_path
        page.should have_content "#{student.name}"
      end

      it 'deletes forever' do
        visit gaku.students_admin_disposals_path
        page.should have_content "#{student.name}"
        click delete_link
        accept_alert
        flash_destroyed?
        page.should_not have_content "#{student.name}"
        visit gaku.students_admin_disposals_path
        page.should_not have_content "#{student.name}"
        visit gaku.listing_applicants_admin_admissions_path
        page.should_not have_content "#{student.name}"
        visit gaku.students_path
        page.should_not have_content "#{student.name}"
      end
    end
  end
end
