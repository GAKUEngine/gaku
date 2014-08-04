require 'spec_helper'

describe 'Admin Student Review Category' do

  before { as :admin }
  before(:all) { set_resource 'admin-student-review-category' }

  let(:student_review_category) { create(:student_review_category, name: 'performance') }

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#types-master-menu a'
      click '#student-review-categories-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'student_review_category_name', with: 'Performance'
        click submit
        flash_created?
      end.to change(Gaku::StudentReviewCategory, :count).by(1)

      has_content? 'Performance'
      count? 'Student review categories list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do

    before do
      student_review_category
      visit gaku.admin_root_path
      click '#types-master-menu a'
      click '#student-review-categories-menu a'
    end

    context '#edit ', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'has validations' do
        fill_in 'student_review_category_name', with: ''
        has_validations?
      end

      it 'edits' do
        fill_in 'student_review_category_name', with: 'Test category'
        click submit

        flash_updated?
        has_content? 'Test category'
        has_no_content? 'Performance'
        expect(student_review_category.reload.name).to eq 'Test category'
      end
    end

    it 'deletes', js: true do
      has_content? student_review_category.name
      count? 'Student review categories list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::StudentReviewCategory, :count).by(-1)

      count? 'Student review categories list(1)'
      has_content? student_review_category.name
    end

  end
end
