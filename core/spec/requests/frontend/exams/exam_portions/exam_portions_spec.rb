require 'spec_helper'

describe 'Exam Portions' do

  let!(:exam) { create(:exam, name: 'Linux') }
  let(:exam_portion) { create(:exam_portion, exam: exam) }


  before(:all) { set_resource 'exam-exam-portion' }
  before { as :admin }

  context '#new', js: true do
    before do
      visit gaku.edit_exam_path(exam)
      click new_link
      wait_until_visible submit
    end

    it 'creates new exam' do
      expect do
        fill_in 'exam_portion_name', with: 'Biology Exam Portion'

        click submit
        flash_created?
      end.to change(Gaku::ExamPortion, :count).by 1

      within(table) { has_content? 'Biology Exam Portion' }
      count? 'Exam Portions list(1)'
    end

    it { has_validations? }

  end

  context 'existing' do
    before do
      exam_portion
    end

    context '#edit from edit view', js: true do
      before { visit gaku.edit_exam_exam_portion_path(exam, exam_portion) }

      it 'edits' do
        fill_in 'exam_portion_name', with: 'Biology 2012 Portion'
        click submit

        flash_updated?
        has_content? 'Biology 2012 Portion'
        has_no_content? exam_portion.name

        exam_portion.reload
        expect(exam_portion.name).to eq 'Biology 2012 Portion'
        expect(current_path).to eq gaku.edit_exam_exam_portion_path(exam, exam_portion)
      end

      it 'has validations' do
        fill_in 'exam_portion_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      visit gaku.edit_exam_path(exam)

      count? 'Exam Portions list(1)'
      within(table) { has_content? exam_portion.name }

      expect do
        click delete_link
        accept_alert
        wait_until { flash_destroyed? }
      end.to change(Gaku::ExamPortion, :count).by -1

      within(count_div) { has_no_content? 'Exam Portions list(1)' }
      within(table) { has_no_content? exam_portion.name }


    end

  end

end
