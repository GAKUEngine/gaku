require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Admin School Details' do

  let!(:school) { create(:school, primary: true) }

  before do
    as :admin
    @file_name = 'school_picture'
    visit gaku.admin_school_details_path
  end

  context 'upload avatar', js: true do
    before do
      click '#edit-admin-primary-school'
      accept_alert
    end

    it_behaves_like 'upload avatar'
  end

  context 'show avatar' do
    it_behaves_like 'show avatar'
  end

end
