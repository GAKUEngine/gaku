require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Teacher Picture' do

  before { as :admin }

  let(:teacher) { create(:teacher) }

  before do
    visit gaku.edit_teacher_path(teacher)
  end

  context 'avatarable' do

    before { @file_name = 'teacher_picture' }
    it_behaves_like 'new avatar'

  end

end
