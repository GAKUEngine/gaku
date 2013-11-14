require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Teacher Picture' do

  let(:teacher) { create(:teacher) }

  before do
    as :admin
    @file_name = 'teacher_picture'
  end

  context 'show avatar' do
    before { visit gaku.teacher_path(teacher) }
    it_behaves_like 'show avatar'
  end

  context 'upload avatar' do
    before { visit gaku.edit_teacher_path(teacher) }
    it_behaves_like 'upload avatar'
  end

end
