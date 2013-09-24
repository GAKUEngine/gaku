require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Admin School Details' do

  before { as :admin }

  let(:school) { create(:school, primary: true) }

  before do
    school
    visit gaku.admin_school_details_path
  end

  context 'avatarable' do

    before { @file_name = 'school_picture' }
    it_behaves_like 'new avatar'

  end

end
