require 'spec_helper'

describe 'Sign Out' do

  before { as :admin }

  it 'signs out', js: true do
    visit gaku.root_path
    click '#user_menu_dropdown'
    within('#user_menu') { click_link 'Sign Out' }

    has_content? "Signed out successfully."
    expect(current_path).to eq gaku.new_user_session_path
  end

end
