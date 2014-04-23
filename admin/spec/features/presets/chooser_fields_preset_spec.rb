require 'spec_helper'

describe 'Admin Presets Chooser Fields' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset, active: true) }

  before do
    visit gaku.admin_root_path
    click '#presets-menu a'
    click js_edit_link
    click '#admin-preset-chooser-fields-tab-link'
  end

  it 'saves', js: true do
    check 'preset_chooser_fields[show_class_name]'
    check 'preset_chooser_fields[show_admitted]'
    check 'preset_chooser_fields[show_primary_address]'
    check 'preset_chooser_fields[show_primary_contact]'
    check 'preset_chooser_fields[show_personal_information]'
    click submit

    flash_updated?
    click '#admin-preset-chooser-fields-tab-link'
    expect(find_field('preset_chooser_fields[show_class_name]')).to be_checked
    expect(find_field('preset_chooser_fields[show_admitted]')).to be_checked
    expect(find_field('preset_chooser_fields[show_primary_address]')).to be_checked
    expect(find_field('preset_chooser_fields[show_primary_contact]')).to be_checked
    expect(find_field('preset_chooser_fields[show_personal_information]')).to be_checked

    preset.reload
    expect(preset['chooser_fields']['show_class_name']).to eq '1'
    expect(preset['chooser_fields']['show_admitted']).to eq '1'
    expect(preset['chooser_fields']['show_primary_address']).to eq '1'
    expect(preset['chooser_fields']['show_primary_contact']).to eq '1'
    expect(preset['chooser_fields']['show_personal_information']).to eq '1'
  end

end
