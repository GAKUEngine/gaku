require 'spec_helper'

describe 'Change Language' do

  before { as :admin }

  it 'changes language', js: true do
    visit gaku.root_path
    click '#user_menu_dropdown'
    within('#user_menu') { click_link 'Language' }
    sleep 0.1
    select '日本語', from: 'select_lang'
    click '#btn_config_save'
    has_content? "Language is set to 日本語"
  end

end
