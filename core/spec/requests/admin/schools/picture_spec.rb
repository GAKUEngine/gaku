require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Admin School Picture' do

  let!(:school) { create(:school) }

  before do
    as :admin
    @file_name = 'school_picture'
  end

  context 'upload avatar' do
    before { visit gaku.edit_admin_school_path(school) }
    it_behaves_like 'upload avatar'
  end

  context 'show avatar' do
    before { visit gaku.admin_school_path(school) }
    it_behaves_like 'show avatar'
  end

end
