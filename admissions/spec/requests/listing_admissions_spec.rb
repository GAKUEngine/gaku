require 'spec_helper'

describe 'Admin Listing Admissions' do

  stub_authorization!

  let!(:attendance) { create(:attendance) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }
  let!(:student) { create(:student, enrollment_status_id:enrollment_status_applicant.id) }
  let(:admission_period) { create(:admission_period) }
  context 'lists admissions and', js:true do

    before do
      @admission = create(:admission, 
                          student_id: student.id)
      student.admission = @admission
      student.save!

      visit gaku.admin_admissions_path

      page.should have_content 'Listing Admissions'
      click_on 'Listing Admissions'
      current_path.should == "/admin/admissions/listing_admissions"
      page.should have_content 'Admission Candidates List'
      page.should have_content "#{@admission.admission_period.admission_methods.first.name}"
      page.should have_content "#{@admission.admission_period.admission_methods.first.admission_phases.first.name}"
      page.should have_content "#{student.name}"
    end

    it 'edits admissions' do
      click '.edit-link'
      wait_until_visible modal
      fill_in 'student_name', with: 'Martina'
      click_on 'Save Student'
      wait_until_invisible modal
      page.should have_content 'Martina'
      visit gaku.listing_admissions_admin_admissions_path
      page.should have_content 'Martina' 
    end

    it 'shows admissions' do
      click '.show-link'
      current_path.should eq "/admin/students/1"
      page.should have_content "#{student.name}"
    end

    context 'deleting' do

      it 'deletes admission from index table' do
        click delete_link
        accept_alert
        page.should_not have_content "#{student.name}"
        visit gaku.listing_admissions_admin_admissions_path
        page.should_not have_content "#{student.name}"
        visit gaku.students_admin_disposals_path
        page.should_not have_content "#{student.name}"
        visit gaku.admin_admissions_path
        click_on 'new-create-multiple-admissions-student-link'
        wait_for_ajax
        page.should have_content "#{student.name}"
      end

      it 'deletes student from show view' do
        click '.show-link'
        current_path.should eq "/admin/students/1"
        page.should have_content "#{student.name}"
        click '#delete-student-link'
        within(modal) { click_on "Delete" }
        accept_alert
        wait_for_ajax
        student.reload
        page.should have_content "successfully"
        current_path.should == "/admin/admissions/listing_admissions"
        page.should_not have_content "#{student.name}"
        visit gaku.listing_admissions_admin_admissions_path
        page.should_not have_content "#{student.name}"
        visit gaku.students_path
        page.should_not have_content "#{student.name}"
        visit gaku.students_admin_disposals_path
        page.should have_content "#{student.name}"
      end

    end
    
    it 'goes to admissions' do
      page.should have_content 'Admissions'
      click_on 'Admissions'
      current_path.should eq "/admin/admissions"
      page.should have_content 'Admission Candidates List'
      page.should have_content "#{student.name}"
    end

    it 'goes to applicants list' do
      page.should have_content 'Applicants List'
      click_on 'Applicants List'
      current_path.should eq "/admin/admissions/listing_applicants"
      page.should have_content 'Admission Candidates List'
      page.should have_content "#{student.name}"
    end

    context 'when make ajax requests' do
      before do
        admission_period
        visit gaku.listing_admissions_admin_admissions_path
        current_path.should == "/admin/admissions/listing_admissions"
        within('#admissions_links') do
          page.should have_content 'Applicants List'
          page.should_not have_content 'Listing Admissions'
          page.should have_content 'Admissions'
        end
      end

      it 'doesn\'t renames listing buttons on changing period', js:true do # this was issue
        select "#{admission_period.name}", from: 'admission_period_id'
        wait_for_ajax
        within('#admissions_links') do
          page.should have_content 'Applicants List'
          page.should_not have_content 'Listing Admissions'
          page.should have_content 'Admissions'
        end
      end

      it 'doesn\'t renames listing buttons on changing method', js:true do # this was issue
        select "#{admission_period.admission_methods.last.name}", from: 'admission_method_id'
        wait_for_ajax
        within('#admissions_links') do
          page.should have_content 'Applicants List'
          page.should_not have_content 'Listing Admissions'
          page.should have_content 'Admissions'

        end
      end

    end

  end
end