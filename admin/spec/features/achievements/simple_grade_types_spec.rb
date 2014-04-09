require 'spec_helper'

describe 'Admin Simple grade types' do

  before { as :admin }
  before(:all) { set_resource 'admin-simple-grade-type' }

  let(:simple_grade_type) { create(:simple_grade_type) }
  let(:school) { create(:school) }
  let(:grading_method) { create(:grading_method) }

  context 'new', js: true do
    before do
      school; grading_method
      visit gaku.admin_root_path
      click '#simple-grade-types-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'simple_grade_type_name', with: 'AngularJS'
        select school.name, from: 'simple_grade_type_school_id'
        select grading_method.name, from: 'simple_grade_type_grading_method_id'
        click submit
        flash_created?
      end.to change(Gaku::SimpleGradeType, :count).by(1)

      within(table) do
        has_content? school.name
        has_content? grading_method.name
        has_content? 'AngularJS'
      end
      count? 'Simple grade types list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      school;grading_method
      simple_grade_type
      visit gaku.admin_root_path
      click '#simple-grade-types-menu a'
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'simple_grade_type_name', with: 'Ruby dev'
        click submit

        flash_updated?
        within(table) do
          has_content? 'Ruby dev'
          has_no_content? simple_grade_type.name
        end
        expect(simple_grade_type.reload.name).to eq 'Ruby dev'
      end

      it 'has validations' do
        fill_in 'simple_grade_type_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      within(table) {has_content? simple_grade_type.name }
      count? 'Simple grade types list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::SimpleGradeType, :count).by -1

      count? 'Simple grade type list'
      within(table) { has_no_content? simple_grade_type.name }

    end

  end
end
