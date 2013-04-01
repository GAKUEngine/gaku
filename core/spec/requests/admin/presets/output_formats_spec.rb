  require 'spec_helper'

describe 'Admin Presets Output Formats' do

  as_admin

  before do
    visit gaku.output_formats_admin_presets_path
  end

  context '#default', js:true do
    it 'saves' do
      select 'xls', from:'presets_spreadsheets'
      select 'PDF', from:'presets_printables'
      click '#submit-preset'

      flash_updated?
      Gaku::Preset.get('spreadsheets').should eq('xls')
      Gaku::Preset.get('printables').should eq('PDF')

    end
  end

end
