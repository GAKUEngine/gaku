require 'spec_helper'

describe 'Admin Presets Grading' do

  stub_authorization!

  before do
    visit gaku.grading_admin_presets_path
  end
  context '#default', js:true do
    it 'saves' do

      fill_in 'presets_grading_method', with:'Exam'
      fill_in 'presets_grading_scheme', with:'A' 
      click '.btn' 

      flash_updated?
    end
  end

end