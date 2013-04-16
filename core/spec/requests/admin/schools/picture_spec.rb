require 'spec_helper'
require 'support/requests/avatarable_spec'

describe "Admin School Picture" do

  as_admin

  let(:school) { create(:school) }

  before do
    visit gaku.admin_school_path(school)
  end

  context 'avatarable' do

    before { @file_name = 'school_picture' }
    it_behaves_like 'avatarable'  
    
  end
  
end
