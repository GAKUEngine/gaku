require 'spec_helper'

describe 'Course Graidng Method Connectors' do

  let!(:course) { create(:course) }
  let(:grading_method) { create(:grading_method) }

  let(:grading_method_set) { create(:grading_method_set, :with_grading_method) }

  before(:all) { set_resource 'course-grading-method-connector' }

  before { as :admin }

  context 'new', js: true do
    before do
      grading_method
      visit gaku.edit_course_path(course)
      click '#grading-methods-menu a'
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

      count? 'Grading methods list(1)'
    end

    it { has_validations? }
  end

  context 'grading method set', js: true do
    before do
      grading_method_set
    end

    it 'add set grading methods if not in collection' do
      visit gaku.edit_course_path(course)

      click '#grading-methods-menu a'
      click '#new-set-course-grading-method-connector-link'
      expect do
        select grading_method_set.name,
               from: 'grading_method_set_id'
        click '#submit-set-course-grading-method-connector-button'
        flash? 'Grading methods from grading method set added'

      end.to change(Gaku::GradingMethodConnector, :count).by 1
      within(table) { has_content? grading_method_set.grading_methods.first.name }
    end

    it 'do not add set grading methods if already in collection' do
      grading_method_set
      course.grading_method_connectors.create(grading_method: grading_method_set.grading_methods.first)
      visit gaku.edit_course_path(course)

      click '#grading-methods-menu a'
      click '#new-set-course-grading-method-connector-link'
      expect do
        select grading_method_set.name,
               from: 'grading_method_set_id'
        click '#submit-set-course-grading-method-connector-button'
        flash? 'Grading methods are already added'
      end.to change(Gaku::GradingMethodConnector, :count).by 0
    end
  end

  context 'existing', js: true do
    before do
      course.grading_methods << grading_method
      visit gaku.edit_course_path(course)
      click '#grading-methods-menu a'
    end

    it 'deletes', js: true do
      has_content? grading_method.name
      count? 'Grading methods list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::GradingMethodConnector, :count).by(-1)

      has_no_content? 'Grading Methods(1)'
      count? 'Grading methods list'
    end

  end

end
