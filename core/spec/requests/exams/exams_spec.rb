require 'spec_helper'

describe 'Exams' do
  stub_authorization!

  let(:exam) { create(:exam, :name => "Linux") }

  before :all do
    set_resource "exam"
  end

  context '#new', :js => true do
    before do
      visit gaku.exams_path
      click new_link
      wait_until_visible submit
    end

    it 'creates new exam' do  #TODO Add execution_date and data
      tr_count = size_of(table_rows)

      expect do
        fill_in 'exam_name', :with => 'Biology Exam'
        fill_in 'exam_weight', :with => 1
        fill_in 'exam_description', :with => "Good work"

        fill_in 'exam_exam_portions_attributes_0_name', :with => 'Exam Portion 1'
        fill_in 'exam_exam_portions_attributes_0_weight', :with => 1
        fill_in 'exam_exam_portions_attributes_0_problem_count', :with => 1
        fill_in 'exam_exam_portions_attributes_0_max_score', :with => 1

        click submit
        wait_until_invisible submit
      end.to change(Gaku::Exam, :count).by 1

      size_of(table_rows).should eq (tr_count + 1)
      within(count_div) { page.should have_content 'Exams List(1)' }
      flash_created?
    end

    it "cancels creating", :cancel => true do
      ensure_cancel_creating_is_working
    end

    it 'errors without required exam fields' do
      has_validations?
    end

    it 'errors without required exam portion fields' do
      fill_in 'exam_name', :with => 'Exam 1'
      fill_in 'exam_exam_portions_attributes_0_name', :with => ''
      has_validations?
    end
  end

  context 'existing ' do
    before do
      exam
      visit gaku.exams_path
    end

    context '#edit ', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits from index' do
        fill_in 'exam_name', :with => 'Biology 2012'
        click submit
        wait_until_invisible modal

        within(table) { page.should have_content 'Biology 2012' }
        flash_updated?
      end

      it 'errors without required fields on index/edit' do
        fill_in 'exam_name', :with => ''
        has_validations?
      end

      it 'hides weighting widget' do
        uncheck 'Use Weighting'
        click submit
        wait_until_invisible modal

        page.should_not have_content 'Total Weight'
        page.should have_no_selector(:content,'.weight-check-widget')
      end
    end

    context '#show ' do
      before do
        within(table) { click show_link }
        page.should have_content 'Show Exam'
      end

      it 'shows weighting widget' do
        page.should have_content 'Weight'
        page.should have_content 'Total Weight'
      end

      context '#edit', :js => true do
        before do
          click_on "Edit"
          page.should have_content 'Edit Exam'
        end

        it 'edits from show view' do
          fill_in 'exam_name', :with => 'Biology 2012'
          click submit
          page.should have_content 'Biology 2012'
          flash_updated?
        end

        it 'errors without required fields on view/edit' do
          fill_in 'exam_name', :with => ''
          has_validations?
        end
      end
    end
    it 'deletes', :js => true do
      within(count_div) { page.should have_content 'Exams List(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Exam, :count).by -1

      within(count_div) { page.should_not have_content 'Exams List(1)' }
      page.should_not have_content exam.name
      flash_destroyed?
    end

    it 'returns to index when back is selected' do
      visit gaku.exam_path(exam)
      click_on 'Back'
      page.should have_content 'Exams List'
    end
  end
end
