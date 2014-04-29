require 'spec_helper'

describe 'Exam Portions' do

  let!(:exam) { create(:exam, name: 'Linux') }
  let(:exam_portion) { create(:exam_portion, exam: exam) }


  before(:all) { set_resource 'exam-exam-portion' }
  before { as :admin }

  context '#new', js: true do
    before do
      visit gaku.edit_exam_path(exam)
      click '#exams-exam-portions-menu a'
      click new_link
    end

    it 'creates new exam portion' do
      expect do
        fill_in 'exam_portion_name', with: 'Biology Exam Portion'

        click submit
        flash_created?
      end.to change(Gaku::ExamPortion, :count).by 1

      within(table) { has_content? 'Biology Exam Portion' }
      within('#exams-exam-portions-menu') { expect(page.has_content?('1')).to eq true }
      within('#exams-exam-portions-menu-list') { expect(page.has_content?('Biology Exam Portion')).to eq true }
    end

    it { has_validations? }

  end

  context 'existing' do
    before do
      exam_portion
    end

    context 'edit', js: true do
      before do
        visit gaku.edit_exam_path(exam)
        click '#exams-exam-portions-menu a'
        click js_edit_link
      end

      it 'edits' do
        fill_in 'exam_portion_name', with: 'Biology 2012 Portion'
        click submit

        flash_updated?
        has_content? 'Biology 2012 Portion'
        has_no_content? exam_portion.name
        within('#exams-exam-portions-menu-list') { expect(page.has_content?('Biology 2012 Portion')).to eq true }

        exam_portion.reload
        expect(exam_portion.name).to eq 'Biology 2012 Portion'
      end

      it 'has validations' do
        fill_in 'exam_portion_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      visit gaku.edit_exam_path(exam)
      click '#exams-exam-portions-menu a'

      within('#exams-exam-portions-menu') { expect(page.has_content?('1')).to eq true }
      within(table) { has_content? exam_portion.name }

      expect do
        click delete_link
        accept_alert
        flash_destroyed?
      end.to change(Gaku::ExamPortion, :count).by -1

      within('#exams-exam-portions-menu') { expect(page.has_no_content?('1')).to eq true }
      #within('#exams-exam-portions-menu-list') { expect(page.has_no_content?(exam_portion.name)).to eq true }
      within(table) { has_no_content? exam_portion.name }
    end

  end

end
