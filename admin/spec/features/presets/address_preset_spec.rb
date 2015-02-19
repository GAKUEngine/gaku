require 'spec_helper'

describe 'Admin Presets Students' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }
  let!(:country) { create(:country) }
  let!(:state) { create(:state, country: country) }

  before do
    visit gaku.admin_root_path
    click '#presets-menu a'
    click js_edit_link
    click '#admin-preset-address-tab-link'
  end

  it 'saves', js: true do
    select country.name, from: 'country_dropdown'
    select state.name, from: 'preset_address_state'
    fill_in 'preset_address_city', with: 'Varna'
    click submit

    flash_updated?
    click '#admin-preset-address-tab-link'
    expect(find_field('country_dropdown').value).to eq "#{country.id}"
    expect(find_field('preset_address_state').value).to eq "#{state.id}"
    expect(find_field('preset_address_city').value).to eq 'Varna'

    preset.reload
    expect(preset['address']['country']). to eq "#{country.id}"
    expect(preset['address']['state']). to eq "#{state.id}"
    expect(preset['address']['city']). to eq 'Varna'
  end

end
