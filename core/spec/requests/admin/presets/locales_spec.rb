require 'spec_helper'

describe 'Admin Presets Locales' do

  stub_authorization!

  before do
    visit gaku.locale_admin_presets_path
  end
  context '#default', js:true do
    it 'saves' do

      select 'en', from:'presets_language'
      click '.btn' 

      flash_updated?
    end
  end

end