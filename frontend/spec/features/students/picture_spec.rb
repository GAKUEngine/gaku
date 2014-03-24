require 'spec_helper'

describe 'Student Picture' do

  let(:student) { create(:student) }

  before do
    as :admin
    @file_name = 'student_picture'
    visit gaku.edit_student_path(student)
  end

  context 'show avatar' do
    it_behaves_like 'show avatar'
  end

  it 'upload avatar', js: true do
    sleep 0.5
    click '#upload-picture-link'
    expect do
    attach_file :student_picture,
            File.join(Rails.root + '../support/120x120.jpg')
    click_button 'Upload'
    wait_for_ajax
    student.reload
    flash_updated?
    end.to change(student, :picture_content_type).from(nil).to('image/jpeg')
  end

end
