require 'spec_helper'
require 'support/requests/avatarable_spec'

describe "Teacher Picture" do

  as_admin

  let(:teacher) { create(:teacher) }

  before do
    visit gaku.teacher_path(teacher)
  end

  context 'avatarable' do

    before { @file_name = 'teacher_picture' }
    it_behaves_like 'avatarable'  
    
  end

end
