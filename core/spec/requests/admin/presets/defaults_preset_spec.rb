require 'spec_helper'

describe 'Admin Presets Defaults' do

  before { as :admin }

  before do
    visit gaku.defaults_admin_presets_path
  end

  context '#default', js:true do
    xit 'saves' do
      check 'presets_chooser_table_fields[surname]'
      click '#submit-preset'

      flash_updated?
      expect(Gaku::Preset.load_presets_hash(Gaku::Preset::PRESETS[:default])).to eq({names: "%first_name"})
    end
  end

end
