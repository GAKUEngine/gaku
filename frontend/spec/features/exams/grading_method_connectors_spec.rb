require 'spec_helper'

describe 'Exam Graidng Method Connectors' do

  let!(:exam) { create(:exam) }
  let(:grading_method) { create(:grading_method) }

  before(:all) { set_resource 'exam-grading-method-connector' }

  before { as :admin }

  context 'new', js: true do
    before do
      grading_method
      visit gaku.edit_exam_path(exam)
      click '#exam-grading-method-connectors-tab-link'
      click new_link
    end

    it 'creates and shows' do
      expect do
        select grading_method.name,
          from: 'grading_method_connector_grading_method_id'

        click submit
        flash_created?
      end.to change(Gaku::GradingMethodConnector, :count).by 1

      within(table) do
        has_content? grading_method.name
      end

      within('#exam-grading-method-connectors-tab-link') do
        has_content? 'Grading Methods(1)'
      end

      count? 'Grading methods list(1)'
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      exam.grading_methods << grading_method
      visit gaku.edit_exam_path(exam)
      click '#exam-grading-method-connectors-tab-link'
    end

    it 'deletes', js: true do
      has_content? grading_method.name
      count? 'Grading methods list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::GradingMethodConnector, :count).by -1

      within('#exam-grading-method-connectors-tab-link') do
        has_no_content? 'Grading Methods(1)'
      end

      count? 'Grading methods list'

    end

  end

end
