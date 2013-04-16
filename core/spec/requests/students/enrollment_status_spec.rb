require 'spec_helper'

describe 'Student Enrollment Status' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:student2) { create(:student, :with_enrollment_status) }
  let!(:enrollment_status) { create(:enrollment_status) }
  let!(:enrollment_status2) { create(:enrollment_status, :name => "New Enrollment") }
  let!(:el) { '#enrollment-status' }
  let!(:select_box) { 'select.input-medium' }

  context '#new', :js => true do

    before do
      visit gaku.edit_student_path(student)
      within(el) { page.should have_content "Empty"}
      click el
      wait_until_visible select_box
    end

    it 'create and show' do
      within(select_box) {  click_option enrollment_status2 }

      wait_until_invisible select_box
      within(el) { page.should have_content(enrollment_status2.name) }
      student.reload
      student.enrollment_status.should eq enrollment_status2
    end


  end

  context 'existing',  :js => true do
    before do
      student2
      visit gaku.edit_student_path(student2)
      within(el) { page.should have_content(enrollment_status)}
      click el
      wait_until_visible select_box
    end

    context '#edit' do

      it 'edits' do
        within(select_box) { click_option enrollment_status2 }

        wait_until_invisible select_box
        within(el) { page.should have_content(enrollment_status2.name) }
        student2.reload
        student2.enrollment_status.should eq enrollment_status2
      end

    end

  end
end
