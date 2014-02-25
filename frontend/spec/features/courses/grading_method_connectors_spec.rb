require 'spec_helper'

describe 'Course Graidng Method Connectors' do

  let!(:course) { create(:course) }
  let(:grading_method) { create(:grading_method) }

  before(:all) { set_resource 'course-grading-method-connector' }

  before { as :admin }

  context 'new', js: true do
    before do
      grading_method
      visit gaku.edit_course_path(course)
      click '#course-grading-method-connectors-tab-link'
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

      within('#course-grading-method-connectors-tab-link') do
        has_content? 'Grading Methods(1)'
      end

      count? 'Grading methods list(1)'
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      course.grading_methods << grading_method
      visit gaku.edit_course_path(course)
      click '#course-grading-method-connectors-tab-link'
    end

    it 'deletes', js: true do
      has_content? grading_method.name
      count? 'Grading methods list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::GradingMethodConnector, :count).by -1

      within('#course-grading-method-connectors-tab-link') do
        has_no_content? 'Grading Methods(1)'
      end

      count? 'Grading methods list'

    end

  end

end
