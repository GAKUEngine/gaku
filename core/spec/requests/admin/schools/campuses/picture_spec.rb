require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Admin School Campus Picture' do

  let(:school) { create(:school) }

  before do
    as :admin
    @file_name = 'campus_picture'
  end

  context 'show avatar' do
    before do
      visit gaku.admin_school_path(school)
      click show_link
    end

    it_behaves_like 'show avatar'
  end

  context 'upload avatar' do
    before do
      visit gaku.edit_admin_school_path(school)
      click edit_link
    end

    it_behaves_like 'upload avatar'
  end

end
