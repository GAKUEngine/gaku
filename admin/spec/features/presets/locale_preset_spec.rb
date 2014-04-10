require 'spec_helper'

describe 'Admin Presets Locale' do

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
    select 'en', from:'preset_locale'
    click submit

    flash_updated?
    click '#admin-preset-locale-tab-link'
    expect(find_field('preset_locale').value).to eq 'en'

    preset.reload
    expect(preset.locale).to eq 'en'
  end

end
