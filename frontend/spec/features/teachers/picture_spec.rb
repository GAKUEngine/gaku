require 'spec_helper'

describe 'Teacher Picture' do

   let(:teacher) { create(:teacher) }

  before do
    as :admin
    visit gaku.edit_teacher_path(teacher)
  end

  context 'show avatar' do
    it_behaves_like 'show avatar'
  end

  it 'upload avatar', js: true do
    sleep 0.5
    click '#avatar-picture'
    expect do
    attach_file :teacher_picture,
            File.join(Rails.root + '../support/120x120.jpg')
    click_button 'Upload'
    wait_for_ajax
    teacher.reload
    flash_updated?
    end.to change(teacher, :picture_content_type).from(nil).to('image/jpeg')
  end

end
