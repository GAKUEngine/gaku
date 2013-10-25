require 'spec_helper'

describe 'Admin States' do

  before { as :admin }
  before(:all) { set_resource 'admin-state' }

  let!(:usa) { create(:country, name: 'USA', iso: 'US') }
  let!(:japan) { create(:country, name: 'Japan', iso: 'JP') }

  context 'new', js: true do
    before do
      visit gaku.admin_states_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'state_name',         with: 'Florida'
        fill_in 'state_abbr', with: 'FL'
        fill_in 'state_name_ascii',   with: '123'
        fill_in 'state_code',         with: 'FL'
        select 'USA',                 from: 'state_country_iso'

        click submit
        flash_created?
      end.to change(Gaku::State, :count).by(1)

      count? 'State list(1)'

      select 'USA', from: 'select-country'
      click '#admin-show-country-states-submit'

      has_content? 'Florida'
      has_content? 'FL'
      has_content? '123'
      has_content? 'US'
    end

    it { has_validations? }
  end

  context 'existing' do
    let(:usa_state) { create(:state, name: 'Texas', country_iso: usa.iso) }
    let(:usa_state2) { create(:state, name: 'Ohaio', country_iso: usa.iso) }
    let(:japan_state) { create(:state, name: 'Aichi', country_iso: japan.iso) }

    before do
      usa_state
      usa_state2
      japan_state

      visit gaku.admin_states_path
    end

    it 'shows states per country', js: true do
      count? 'State list'

      select 'USA', from: 'select-country'
      click '#admin-show-country-states-submit'

      count? 'State list(1)'
      has_content? japan_state.name

      select 'Japan', from: 'select-country'
      click '#admin-show-country-states-submit'

      count? 'State list(2)'
      has_content? usa_state.name
      has_content? usa_state2.name
    end
  end
end
