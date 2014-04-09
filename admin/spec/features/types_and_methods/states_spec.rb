require 'spec_helper'

describe 'Admin States' do

  before { as :admin }
  before(:all) { set_resource 'admin-state' }

  let!(:country) { create(:country, name: 'Japan', iso: 'JP')}
  let(:state) { create(:state, name: 'Tokyo ', country: country) }
  let(:country2) { create(:country, name: 'Bulgaria', iso: 'BG')}
  let!(:country_table) { "#admin-#{country.iso.downcase}-states-index" }
  let(:preset) { create(:preset, address: {country: 'JP'}) }

  context 'new', js:true do
    before do
      state; country2
      visit gaku.admin_root_path
      click '#states-menu a'
      click new_link

      select country.name, from: 'select-country'
      click '#admin-show-country-states-submit'

      within(country_table) { has_content? state.name }
    end

    it 'create and show for selected country' do
      expect do
        fill_in 'state_name', with: 'Kanagawa'
        select country.name, from: 'state_country_iso'
        click submit
        flash_created?
      end.to change(Gaku::State, :count).by(1)

      within "#admin-#{country.iso.downcase}-states-index" do
        has_content? 'Kanagawa'
      end
    end

    it 'create and show for non selected country' do
      expect do
        fill_in 'state_name', with: 'Plovdiv'
        select country2.name, from: 'state_country_iso'
        click submit
        flash_created?
      end.to change(Gaku::State, :count).by(1)

      within(country_table) { has_content? 'Kanagawa' }
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      state
      visit gaku.admin_root_path
      click '#states-menu a'

      select country.name, from: 'select-country'
      click '#admin-show-country-states-submit'

      within(country_table) { has_content? state.name }
    end

    context 'edits' do
      before { within(country_table) { click js_edit_link } }

      it 'has validations' do
        fill_in 'state_name', with: ''
        has_validations?
      end

      it 'edits' do
        fill_in 'state_name', with: 'Nagano'
        click submit

        flash_updated?

        within country_table do
          has_content? 'Nagano'
          has_no_content?'Tokyo'
        end

        expect(state.reload.name).to eq 'Nagano'
      end
    end

    it 'deletes' do
      tr_count = size_of "#{country_table} tr"

      expect do
        click delete_link
        accept_alert
        flash_destroyed?
      end.to change(Gaku::State, :count).by(-1)

      within(country_table) { has_no_content? state.name }
    end
  end

  context 'selected country when are set country preset', js: true do
    it 'show country state for country preset' do
      state
      preset
      visit gaku.admin_root_path
      click '#states-menu a'

      within(country_table) { has_content? state.name }
    end
  end
end
