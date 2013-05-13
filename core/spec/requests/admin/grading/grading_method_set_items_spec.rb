require 'spec_helper'

describe 'Admin Grading Method Set Items' do

  as_admin

  let(:grading_method_set) { create(:grading_method_set) }
  let!(:grading_method) { create(:grading_method, name: 'Bulgarian') }
  let!(:grading_method2) { create(:grading_method, name: 'Japanese') }

  let(:grading_method_set_item) do
    create(:grading_method_set_item, grading_method: grading_method,
                                     grading_method_set: grading_method_set)
  end

  before :all do
    set_resource 'admin-grading-method-set-grading-method-set-item'
  end

  context 'new', js: true do
    before do
      grading_method_set
      visit gaku.admin_grading_method_set_path(grading_method_set)
      click new_link
      wait_until_visible submit
    end

    it { has_validations? }

    it 'creates and shows' do
      expect do
        select grading_method.name, from: 'grading_method_set_item_grading_method_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::GradingMethodSetItem, :count).by(1)

      within(table) { page.should have_content 'Bulgarian' }
      within(count_div) { page.should have_content 'Grading Methods list(1)' }
      flash_created?
    end

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      grading_method2
      grading_method_set
      grading_method_set_item
      visit gaku.admin_grading_method_set_path(grading_method_set)
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        select grading_method2.name, from: 'grading_method_set_item_grading_method_id'
        click submit

        wait_until_invisible modal
        within(table) { page.should_not have_content 'Bulgarian' }
        within(table) { page.should have_content 'Japanese' }
        flash_updated?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

      it 'has validations' do
        select '', from: 'grading_method_set_item_grading_method_id'
        has_validations?
      end

    end

    it 'deletes', js: true do
      within(table) { page.should have_content grading_method.name }
      within(count_div) { page.should have_content 'Grading Methods list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::GradingMethodSetItem, :count).by(-1)

      within(count_div) { page.should_not have_content 'Grading Methods list(1)' }
      within(table) { page.should_not have_content grading_method.name }
      flash_destroyed?
    end
  end

end
