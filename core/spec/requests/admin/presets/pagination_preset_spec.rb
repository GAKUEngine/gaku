require 'spec_helper'

describe 'Admin Presets Pagination' do

  before { as :admin }

  before do
    visit gaku.pagination_admin_presets_path
  end

  context '#default', js:true do
    it 'saves' do
      select '25', from: 'presets_default_per_page'
      select '50', from: 'presets_students_per_page'
      select '10', from: 'presets_changes_per_page'
      click '#submit-preset'

      flash_updated?
      expect(Gaku::Preset.load_presets_hash(Gaku::Preset::PRESETS[:pagination])).to eq({default_per_page: "25", students_per_page: "50", changes_per_page: "10"})
    end
  end

end
