require 'spec_helper'

describe 'Admin Achievements' do

  as_admin

  let(:achievement) { create(:achievement, :name => 'gold') }

  before :all do
    set_resource "admin-achievement"
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_achievements_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'achievement_name', :with => 'medal'
        click submit
        wait_until_invisible form
      end.to change(Gaku::Achievement, :count).by 1

      page.should have_content 'medal'
      within(count_div) { page.should have_content 'Achievements list(1)' }
      flash_created?
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do

    before do
      achievement
      visit gaku.admin_achievements_path
    end

    context '#edit ', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'achievement_name', :with => 'bronze'
        click submit

        wait_until_invisible modal
        page.should have_content 'bronze'
        page.should_not have_content 'gold'
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', :js => true do
      page.should have_content achievement.name
      within(count_div) { page.should have_content 'Achievements list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Achievement, :count).by -1

      flash_destroyed?
      page.should_not have_content achievement.name
    end

  end

end
