require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Student Guardian Picture' do

  before { as :admin }

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }

  before do
    student.guardians << guardian
    visit gaku.edit_student_guardian_path(student, guardian)
  end

  context 'avatarable' do

    before { @file_name = 'guardian_picture' }
    it_behaves_like 'new avatar'

  end

end
