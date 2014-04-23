require 'spec_helper'

describe 'Admin Presets Person' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_root_path
    click '#presets-menu a'
    click js_edit_link
    click '#admin-preset-person-tab-link'
  end

  it 'saves', js: true do
    select 'Female', from: 'preset_person_gender'
    click submit

    flash_updated?
    click '#admin-preset-person-tab-link'
    expect(find_field('preset_person_gender').value).to eq 'false'

    preset.reload
    expect(preset['person']['gender']).to eq 'false'
  end
end
