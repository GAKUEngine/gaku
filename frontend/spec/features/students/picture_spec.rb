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
    # absolute_path = Rails.root + '../support/120x120.jpg'
    # attach_file @file_name, absolute_path
    expect do
    attach_file :student_picture,
            File.join(Rails.root + '../support/120x120.jpg')
    click_button 'Upload'
    # counter = 0
    # while page.execute_script("return $.active").to_i > 0
    #   counter += 1
    #   sleep(0.1)
    # raise "AJAX request took longer than 5 seconds." if counter >= 50
    # end
    wait_for_ajax
    student.reload
    flash_updated?
    end.to change(student, :picture_content_type).from(nil).to('image/jpeg')
  end

end
