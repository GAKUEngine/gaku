require 'spec_helper'

describe 'Admin BadgeTypes' do

  before { as :admin }
  before(:all) { set_resource 'admin-badge-type' }

  let(:badge_type) { create(:badge_type, name: 'gold') }

  context 'new', js: true do
    before do
      visit gaku.admin_badge_types_path
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'badge_type_name', with: 'medal'
        click submit
        flash_created?
      end.to change(Gaku::BadgeType, :count).by 1

      has_content? 'medal'
      count? 'Badge types list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do

    before do
      badge_type
      visit gaku.admin_badge_types_path
    end

    context '#edit ', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'badge_type_name', with: 'bronze'
        click submit

        flash_updated?
        has_content? 'bronze'
        has_no_content? 'gold'
        expect(badge_type.reload.name).to eq 'bronze'
      end

      it 'has validations' do
        fill_in 'badge_type_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? badge_type.name
      count? 'Badge types list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::BadgeType, :count).by(-1)

      has_no_content? badge_type.name
    end

  end
end
