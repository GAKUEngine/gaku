require 'spec_helper'

describe 'Admin Presets Grading' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_root_path
    click '#presets-menu a'
    click js_edit_link
    click '#admin-preset-grading-tab-link'
  end

  it 'saves', js: true do
    fill_in 'preset_grading_method', with: 'Exam'
    fill_in 'preset_grading_scheme', with: 'A'
    click submit

    flash_updated?
    click '#admin-preset-grading-tab-link'
    expect(find_field('preset_grading_method').value).to eq 'Exam'
    expect(find_field('preset_grading_scheme').value).to eq 'A'

    preset.reload
    expect(preset['grading']['method']).to eq 'Exam'
    expect(preset['grading']['scheme']).to eq 'A'
  end

end
