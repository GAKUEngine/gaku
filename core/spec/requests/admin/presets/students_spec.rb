require 'spec_helper'

describe 'Admin Presets Students' do

  as_admin

  let(:country) { create(:country) }
  let(:state) { create(:state, country:country) }
  let(:address) { create(:address, country:country, state:state) }

  before do
    address
    visit gaku.students_admin_presets_path
  end

  context '#default', js:true do
    it 'saves' do
      select 'Female', from:'presets_students_gender'
      select "#{address.country}", from:'presets_address_country'
      fill_in 'presets_address_state', with: "#{address.state.name}"
      click '#submit-preset'

      flash_updated?
    end
  end
end
