require 'spec_helper'

describe 'Admin Achievements' do

  before { as :admin }
  before(:all) { set_resource 'admin-achievement' }

  let(:achievement) { create(:achievement, name: 'gold') }

  context 'new', js: true do
    before do
      visit gaku.admin_achievements_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'achievement_name', with: 'medal'
        click submit
        flash_created?
      end.to change(Gaku::Achievement, :count).by 1

      has_content? 'medal'
      count? 'Achievements list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do

    before do
      achievement
      visit gaku.admin_achievements_path
    end

    context '#edit ', js: true do
      before do
        within(table) { click js_edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'achievement_name', with: 'bronze'
        click submit

        flash_updated?
        has_content? 'bronze'
        has_no_content? 'gold'
        expect(achievement.reload.name).to eq 'bronze'
      end

      it 'has validations' do
        fill_in 'achievement_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? achievement.name
      count? 'Achievements list(1)'

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Achievement, :count).by(-1)

      flash_destroyed?
      has_no_content? achievement.name
    end

  end
end
