require 'spec_helper'

describe 'Admin Grading Methods' do

  as_admin

  let(:grading_method) { create(:grading_method, :name => 'Bulgarian') }

  before :all do
    set_resource "admin-grading-method"
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_grading_methods_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'grading_method_name', :with => 'Bulgarian'
        click submit
        wait_until_invisible form
      end.to change(Gaku::GradingMethod, :count).by 1

      page.should have_content 'Bulgarian'
      within(count_div) { page.should have_content 'Grading Methods list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      grading_method
      visit gaku.admin_grading_methods_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'grading_method_name', :with => 'Japanese'
        click submit

        wait_until_invisible modal
        page.should have_content 'Japanese'
        page.should_not have_content 'Bulgarian'
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      page.should have_content grading_method.name
      within(count_div) { page.should have_content 'Grading Methods list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::GradingMethod, :count).by -1

      within(count_div) { page.should_not have_content 'Grading Methods list(1)' }
      page.should_not have_content grading_method.name
      flash_destroyed?
    end
  end

end
