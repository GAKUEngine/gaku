require 'spec_helper'

describe 'Exams' do

  let(:exam) { create(:exam, name: 'Linux') }
  let(:exam2) { create(:exam) }
  let(:department) { create(:department) }

  let(:grading_method_set) { create(:grading_method_set, :with_grading_methods) }

  before(:all) { set_resource 'exam' }
  before { as :admin }

  context '#new', js: true do
    before do
      department
      visit gaku.exams_path
      click new_link
    end

    it 'creates new exam' do
      expect do
        fill_in 'exam_name', with: 'Biology Exam'
        fill_in 'exam_weight', with: 1
        fill_in 'exam_description', with: 'Good work'
        select department.name, from: 'exam_department_id'

        fill_in 'exam_exam_portions_attributes_0_name', with: 'Exam Portion 1'
        fill_in 'exam_exam_portions_attributes_0_weight', with: 1
        fill_in 'exam_exam_portions_attributes_0_problem_count', with: 1
        fill_in 'exam_exam_portions_attributes_0_max_score', with: 1

        click submit
        flash_created?
      end.to change(Gaku::Exam, :count).by 1

      within(table) { has_content? department.name }
      within('#exams-tab-link') { has_content? 'Exams(1)' }
      count? 'Exams list(1)'
    end

    it { has_validations? }

    it 'errors without required exam portion fields' do
      fill_in 'exam_name', with: 'Exam 1'
      fill_in 'exam_exam_portions_attributes_0_name', with: ''
      has_validations?
    end
  end

  context 'new with primary grading method set', js: true do
    before do
      grading_method_set
      department
      visit gaku.exams_path
      click new_link
    end

    it 'create and show' do
      expect do
        fill_in 'exam_name', with: 'Biology Exam'
        fill_in 'exam_weight', with: 1
        fill_in 'exam_description', with: 'Good work'
        select department.name, from: 'exam_department_id'

        fill_in 'exam_exam_portions_attributes_0_name', with: 'Exam Portion 1'
        fill_in 'exam_exam_portions_attributes_0_weight', with: 1
        fill_in 'exam_exam_portions_attributes_0_problem_count', with: 1
        fill_in 'exam_exam_portions_attributes_0_max_score', with: 1

        click submit
        flash_created?
      end.to change(Gaku::Exam, :count).by 1
      within(table) { has_content? 'Biology Exam' }

      click edit_link
      click '#exams-grading-methods-menu a'
      within('#exam-grading-method-connectors-index') do
        has_content? grading_method_set.grading_methods.first
        has_content? grading_method_set.grading_methods.second
      end

    end
  end

  context 'existing' do
    before do
      exam
      department
      visit gaku.exams_path
    end

    context '#edit from edit view', js: true do
      before { visit gaku.edit_exam_path(exam) }

      it 'edits' do
        fill_in 'exam_name', with: 'Biology 2012'
        select department.name, from: 'exam_department_id'
        click submit

        flash_updated?

        has_content? 'Biology 2012'
        has_content? department.name
        has_no_content? exam.name

        exam.reload
        expect(exam.name).to eq 'Biology 2012'
        expect(exam.department).to eq department
      end

      it 'has validations' do
        fill_in 'exam_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      count? 'Exams list(1)'
      within(table) { has_content? exam.name }

      visit gaku.edit_exam_path(exam)

      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::Exam, :count).by -1

      expect(current_path).to eq gaku.exams_path
      count? 'Exams list(1)'

    end

  end

end
