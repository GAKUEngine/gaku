require 'spec_helper'

describe 'Admin Presets Grading' do

  before { as :admin }

  before do
    visit gaku.grading_admin_presets_path
  end

  context '#default', js:true do
    it 'saves' do
      fill_in 'presets_grading_method', with:'Exam'
      fill_in 'presets_grading_scheme', with:'A'
      click '#submit-preset'

      flash_updated?
      expect(Gaku::Preset.load_presets_hash(Gaku::Preset::PRESETS[:grading])).to eq({grading_method: "Exam", grading_scheme: "A"})
    end
  end

end
