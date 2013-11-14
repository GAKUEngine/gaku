require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Student Guardian Picture' do

  let(:student) { create(:student) }
  let(:guardian) { create(:guardian) }

  before do
    as :admin
    @file_name = 'guardian_picture'
    student.guardians << guardian
  end

  context 'upload avatar' do
    before { visit gaku.edit_student_guardian_path(student, guardian) }
    it_behaves_like 'upload avatar'
  end

  context 'show avatar' do
    before { visit gaku.edit_student_guardian_path(student, guardian) }
    it_behaves_like 'show avatar'
  end

end
