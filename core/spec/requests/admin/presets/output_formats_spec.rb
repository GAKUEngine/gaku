  require 'spec_helper'

describe 'Admin Presets Output Formats' do

  as_admin

  before do
    visit gaku.output_formats_admin_presets_path
  end

  context '#default', js:true do
    it 'save spreadsheets' do
      expect do
        select 'xls', from:'presets_spreadsheets'
        click '#submit-preset'
      end.to change { Gaku::Preset.get('spreadsheets') }.to('xls')
      find_field('presets_spreadsheets').find('option[selected]').text.should eq('xls')
      flash_updated?
    end

    it 'save printables' do
      expect do
        select 'PDF', from:'presets_printables'
        click '#submit-preset'
      end.to change { Gaku::Preset.get('printables') }.to('PDF')
      find_field('presets_printables').find('option[selected]').text.should eq('PDF')
      flash_updated?
    end
  end
end
