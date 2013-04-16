require 'spec_helper'
require 'support/requests/avatarable_spec'

describe "Student Picture" do

  as_admin

  let(:student) { create(:student) }

  before do
    visit gaku.edit_student_path(student)
  end

  context 'avatarable' do

    before { @file_name = 'student_picture' }
    it_behaves_like 'avatarable'

  end

end
