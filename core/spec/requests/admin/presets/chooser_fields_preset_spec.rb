require 'spec_helper'

describe 'Admin Presets Chooser Fields' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_presets_path
    click edit_link
    click '#admin-preset-chooser-fields-tab-link'
  end

  it 'saves', js: true do
    check 'preset_chooser_fields[surname]'
    check 'preset_chooser_fields[name]'
    check 'preset_chooser_fields[birth_date]'
    check 'preset_chooser_fields[sex]'
    check 'preset_chooser_fields[class_name]'
    check 'preset_chooser_fields[seat_number]'
    check 'preset_chooser_fields[admitted_on]'
    check 'preset_chooser_fields[primary_address]'
    check 'preset_chooser_fields[primary_contact]'
    check 'preset_chooser_fields[assignments]'
    click submit

    flash_updated?
    click '#admin-preset-chooser-fields-tab-link'
    expect(find_field('preset_chooser_fields[surname]')).to be_checked
    expect(find_field('preset_chooser_fields[name]')).to be_checked
    expect(find_field('preset_chooser_fields[birth_date]')).to be_checked
    expect(find_field('preset_chooser_fields[sex]')).to be_checked
    expect(find_field('preset_chooser_fields[class_name]')).to be_checked
    expect(find_field('preset_chooser_fields[seat_number]')).to be_checked
    expect(find_field('preset_chooser_fields[admitted_on]')).to be_checked
    expect(find_field('preset_chooser_fields[primary_address]')).to be_checked
    expect(find_field('preset_chooser_fields[primary_contact]')).to be_checked
    expect(find_field('preset_chooser_fields[assignments]')).to be_checked

    preset.reload
    expect(preset['chooser_fields']['surname']).to eq '1'
    expect(preset['chooser_fields']['name']).to eq '1'
    expect(preset['chooser_fields']['birth_date']).to eq '1'
    expect(preset['chooser_fields']['sex']).to eq '1'
    expect(preset['chooser_fields']['class_name']).to eq '1'
    expect(preset['chooser_fields']['seat_number']).to eq '1'
    expect(preset['chooser_fields']['admitted_on']).to eq '1'
    expect(preset['chooser_fields']['primary_address']).to eq '1'
    expect(preset['chooser_fields']['primary_contact']).to eq '1'
    expect(preset['chooser_fields']['assignments']).to eq '1'
  end

end
