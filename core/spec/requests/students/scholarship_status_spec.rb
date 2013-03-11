require 'spec_helper'

describe 'Student Scholarship Status' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:student2) { create(:student, :with_scholarship_status) }
  let!(:scholarship_status) { create(:scholarship_status) }
  let!(:scholarship_status2) { create(:scholarship_status, :name => "New Scholarship Status") }
  let!(:el) { '#scholarship-status' }
  let!(:select_box) { 'select.input-medium' }

  context '#new', :js => true do

    before do
      visit gaku.edit_student_path(student)
      within(el) { page.should have_content "Empty"}
      click el
      wait_until_visible select_box
    end

    it 'create and show' do
      within(select_box) {  click_option scholarship_status2 }

      wait_until_invisible select_box
      within(el) { page.should have_content(scholarship_status2.name) }
      student.reload
      student.scholarship_status.should eq scholarship_status2
    end


  end

  context 'existing',  :js => true do
    before do
      student2
      visit gaku.edit_student_path(student2)
      within(el) { page.should have_content(scholarship_status)}
      click el
      wait_until_visible select_box
    end

    context '#edit' do

      it 'edits' do
        within(select_box) { click_option scholarship_status2 }

        wait_until_invisible select_box
        within(el) { page.should have_content(scholarship_status2.name) }
        student2.reload
        student2.scholarship_status.should eq scholarship_status2
      end

    end

  end
end
