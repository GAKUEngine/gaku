require 'spec_helper'

describe 'Admin Presets Names' do

  before { as :admin }

  before do
    visit gaku.names_admin_presets_path
  end

  context '#default', js:true do
    it 'saves' do
      fill_in 'presets_names', with: '%first_name'
      click '#submit-preset'

      flash_updated?
      expect(Gaku::Preset.load_presets_hash(Gaku::Preset::PRESETS[:names])).to eq({names: "%first_name"})
    end
  end

end
