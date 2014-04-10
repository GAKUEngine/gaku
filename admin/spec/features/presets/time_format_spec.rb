require 'spec_helper'

describe 'Admin Presets Time Format' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_root_path
    click '#presets-menu a'
    click js_edit_link
    click '#admin-preset-locale-tab-link'
  end

  it 'saves', js: true do
    select 'am/pm', from:'preset_time_format_24'
    click submit

    flash_updated?
    click '#admin-preset-locale-tab-link'
    expect(find_field('preset_time_format_24').value).to eq 'false'

    preset.reload
    expect(preset.time_format_24).to eq false
  end

end
