require 'spec_helper'

describe 'Student Commute Method Type' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:student2) { create(:student, :with_commute_method_type) }
  let!(:commute_method_type) { create(:commute_method_type, :name => "Bus") }
  let!(:commute_method_type2) { create(:commute_method_type, :name => "Train") }
  let!(:el) { '#commute-method-type' }
  let!(:select_box) { 'select.input-medium' }

  context '#new', :js => true do

    before do
      visit gaku.edit_student_path(student)
      within(el) { page.should have_content "Empty"}
      click el
      wait_until_visible select_box
    end

    it 'create and show' do
      within(select_box) {  click_option commute_method_type2 }

      wait_until_invisible select_box
      within(el) { page.should have_content(commute_method_type2.name) }
      student.reload
      student.commute_method_type.should eq commute_method_type2
    end


  end

  context 'existing',  :js => true do
    before do
      student2
      visit gaku.edit_student_path(student2)
      within(el) { page.should have_content("Car")}
      click el
      wait_until_visible select_box
    end

    context '#edit' do

      it 'edits' do
        within(select_box) { click_option commute_method_type2 }

        wait_until_invisible select_box
        within(el) { page.should have_content(commute_method_type2.name) }
        student2.reload
        student2.commute_method_type.should eq commute_method_type2
      end

    end

  end
end
