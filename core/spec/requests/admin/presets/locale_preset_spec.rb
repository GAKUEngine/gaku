  require 'spec_helper'

describe 'Admin Presets Locales' do

  before { as :admin }

  before do
    visit gaku.locale_admin_presets_path
  end

  context '#default', js:true do
    it 'saves' do
      expect(Gaku::Preset.load_presets_hash(Gaku::Preset::PRESETS[:locale])).to eq({})
      select 'en', from:'presets_language'
      click '#submit-preset'

      flash_updated?
      expect(Gaku::Preset.load_presets_hash(Gaku::Preset::PRESETS[:locale])).to eq({language: 'en'})
    end
  end

end
