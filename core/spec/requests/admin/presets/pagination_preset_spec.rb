require 'spec_helper'

describe 'Admin Presets Pagination' do

  before(:all) { set_resource 'admin-preset' }
  before { as :admin }

  let!(:preset) { create(:preset) }

  before do
    visit gaku.admin_presets_path
    click edit_link
  end

  it 'saves' do
    select '25', from: 'preset_pagination_default'
    select '50', from: 'preset_pagination_students'
    select '10', from: 'preset_pagination_teachers'
    select '10', from: 'preset_pagination_changes'
    click submit

    flash_updated?
    expect(find_field('preset_pagination_default').value).to eq '25'
    expect(find_field('preset_pagination_students').value).to eq '50'
    expect(find_field('preset_pagination_teachers').value).to eq '10'
    expect(find_field('preset_pagination_changes').value).to eq '10'

    preset.reload
    expect(preset['pagination']['default']).to eq '25'
    expect(preset['pagination']['students']).to eq '50'
    expect(preset['pagination']['teachers']).to eq '10'
    expect(preset['pagination']['changes']).to eq '10'
  end

end
