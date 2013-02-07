require 'spec_helper'

describe 'Admin Admissions Grading' do

  stub_authorization!

  let!(:attendance) { create(:attendance) }
  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }
  let!(:student) { create(:student, enrollment_status_id:enrollment_status_applicant.id, is_deleted:false, admitted:false) }
  

  before do
    @admission = create(:admission, 
                          student_id: student.id)
    student.admission = @admission
    student.save!
    visit gaku.admin_admissions_path
  end

  context 'grades', js:true do

    before do
      page.should have_content "#{@admission.admission_period.name}"
      page.should have_content "#{@admission.admission_period.admission_methods.first.name}"
      page.should have_content "#{student.name}"
      page.should have_content 'Grade Exam'
      click_on 'Grade Exam'
    end

    it 'grades' do
      fill_in 'portion_score', with: 89
      sleep 3 #this is needed because sometimes test fails
      click '.exam-parts' #TODO fix this
      wait_for_ajax
      visit gaku.admin_admissions_path
      select 'Passed', from: 'state_id'
      click_on 'Save'
      page.should have_content 89
    end

    it 'errors with invalid points' do
      fill_in 'portion_score', with: -120 #Max score is 100
      click '.exam-parts' #TODO fix this
      wait_for_ajax
      page.has_css? '.score-error'
      fill_in 'portion_score', with: 120
      click '.exam-parts' #TODO fix this
      wait_for_ajax
      page.has_css? '.score-error'
      visit gaku.admin_admissions_path
      select 'Passed', from: 'state_id'
      click_on 'Save'
      page.should_not have_content 120
    end

  end
  
  context 'attendance', js:true do

    before do
      page.has_content?('Grade Exam') 
      click_on 'Grade Exam'
      click '.btn'
      page.should have_css '.popover-content'
      #TODO add some predefined reasons
    end

    it 'selects attendance reason' do
      select 'Illness', from: 'preset-reasons'
      click_on 'Submit'
      page.should_not have_css '.popover-content'
      find('.score-cell')['disabled'].should == "true" #for phantom it should == "disabled"
    end

    it 'adds attendance custom reason' do
      fill_in 'custom-reason', with: 'Illness' 
      click_on 'Submit'
      page.should_not have_css '.popover-content'
      find('.score-cell')['disabled'].should == "true"
    end

    it 'removes attendance reason' do
      fill_in 'custom-reason', with: 'Illness' 
      click_on 'Submit'
      page.should_not have_css '.popover-content'
      find('.score-cell')['disabled'].should == "true"
      click '.btn'
      page.find('.delete-attendance').click
      wait_for_ajax
      find('.score-cell')['disabled'].should == nil
    end

  end
end