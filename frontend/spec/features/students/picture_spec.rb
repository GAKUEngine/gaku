require 'spec_helper'

describe 'Student Picture' do

   let(:student) { create(:student) }
   let(:student_with_picture) { create(:student,
    picture: ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/../support/120x120.jpg"), :filename => "120x120.jpg")
    )}

  before do
    as :admin
  end

  context 'without picture' do
    before do
      visit gaku.edit_student_path(student)
    end


    it 'upload avatar', js: true do
      click '#avatar-picture'
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

  context 'with picture' do
    before do
      visit gaku.edit_student_path(student_with_picture)
    end

    context 'show avatar' do
      it_behaves_like 'show avatar'
    end

    it 'remove avatar', js: true do
      click '#avatar-picture'
      click '.remove-picture-link'
      accept_alert
      wait_for_ajax
      flash_destroyed?
      student_with_picture.reload
      expect(student_with_picture.picture).to_not be_file
    end
  end

end
