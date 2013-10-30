  require 'spec_helper'

describe 'Admin Presets Export Formats' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_presets_path
    click edit_link
    click '#admin-preset-export-formats-tab-link'
  end

  it 'saves', js: true do
    select 'xls', from: 'preset_export_formats_spreadsheets'
    select 'ps', from: 'preset_export_formats_printables'
    click submit

    flash_updated?
    click '#admin-preset-export-formats-tab-link'
    expect(find_field('preset_export_formats_spreadsheets').value).to eq 'xls'
    expect(find_field('preset_export_formats_printables').value).to eq 'ps'

    preset.reload
    expect(preset['export_formats']['spreadsheets']).to eq 'xls'
    expect(preset['export_formats']['printables']).to eq 'ps'
  end
end
