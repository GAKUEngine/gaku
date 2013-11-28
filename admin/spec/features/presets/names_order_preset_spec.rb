require 'spec_helper'

describe 'Admin Presets Names Order' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_presets_path
    click edit_link
    click '#admin-preset-names-order-tab-link'
  end

  it 'saves', js: true do
    fill_in 'preset_names_order', with: '%first %middle %last'
    click submit

    flash_updated?
    click '#admin-preset-names-order-tab-link'
    expect(find_field('preset_names_order').value).to eq '%first %middle %last'

    preset.reload
    expect(preset.names_order).to eq '%first %middle %last'
  end

end

