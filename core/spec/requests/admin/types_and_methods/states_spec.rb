require 'spec_helper'

describe 'Admin States' do

  as_admin

  let!(:country) { create(:country, name: 'Japan', iso: 'JP')}
  let(:state) { create(:state, name: 'Tokyo ', country: country) }
  let(:country2) { create(:country, name: 'Bulgaria', iso: 'BG')}
  let!(:country_table) { "#admin-#{country.iso.downcase}-states-index" }

  before :all do
    set_resource 'admin-state'
  end

  context 'new', js:true do
    before do
      state; country2
      visit gaku.admin_states_path
      click new_link
      wait_until_visible submit

      select country.name, from: 'select-country'
      click '#admin-show-country-states-submit'

      within country_table do
        page.should have_content(state.name)
      end
    end

    it 'create and show for selected country' do
      expect do
        fill_in 'state_name', with: 'Kanagawa'
        select country.name, from: 'state_country_iso'
        click submit
        wait_until_invisible form
      end.to change(Gaku::State, :count).by(1)

      flash_created?
      within "#admin-#{country.iso.downcase}-states-index" do
        page.should have_content('Kanagawa')
      end
    end

    it 'create and show for non selected country' do
      expect do
        fill_in 'state_name', with: 'Plovdiv'
        select country2.name, from: 'state_country_iso'
        click submit
        wait_until_invisible form
      end.to change(Gaku::State, :count).by(1)

      flash_created?
      within country_table do
        page.should_not have_content('Kanagawa')
      end
    end

    it { has_validations? }

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', js: true do
    before do
      state
      visit gaku.admin_states_path

      select country.name, from: 'select-country'
      click '#admin-show-country-states-submit'

      within country_table do
        page.should have_content(state.name)
      end
    end

    context 'edits' do
      before do
        within country_table do
          click edit_link
        end
      end

      it 'has validations' do
        fill_in 'state_name', with: ''
        has_validations?
      end

      it 'edits' do
        fill_in 'state_name', :with => 'Nagano'
        click submit

        wait_until_invisible modal
        within country_table do
          page.should have_content 'Nagano'
          page.should_not have_content 'Tokyo'
        end

        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes' do
      tr_count = size_of "#{country_table} tr"

      expect do
        click delete_link
        accept_alert
        wait_until { size_of("#{country_table} tr") == tr_count - 1 }
      end.to change(Gaku::State, :count).by(-1)

      within country_table do
        page.should_not have_content(state.name)
      end
    end
  end

  context 'selected country when are set country preset', js: true do
    it 'show country state for country preset' do
      state
      Gaku::Preset.set 'address_country', 'JP'
      visit gaku.admin_states_path

      within country_table do
        page.should have_content state.name
      end
    end
  end
end