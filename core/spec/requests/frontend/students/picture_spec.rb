require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Student Picture' do

  let(:student) { create(:student) }

  before do
    as :admin
    @file_name = 'student_picture'
    visit gaku.edit_student_path(student)
  end

  context 'show avatar' do
    before { visit gaku.student_path(student) }
    it_behaves_like 'show avatar'
  end

  context 'upload avatar' do
    before { visit gaku.edit_student_path(student) }
    it_behaves_like 'upload avatar'
  end

end
