require 'spec_helper'

describe 'Teacher Picture' do

   let(:teacher) { create(:teacher) }
   let(:teacher_with_picture) { create(:teacher,
    picture: ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/../support/120x120.jpg"), :filename => "120x120.jpg")
    )}

  before do
    as :admin
  end

  context 'without picture' do
    before do
      visit gaku.edit_teacher_path(teacher)
    end


    it 'upload avatar', js: true do
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

  context 'with picture' do
    before do
      visit gaku.edit_teacher_path(teacher_with_picture)
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
      teacher_with_picture.reload
      expect(teacher_with_picture.picture).to_not be_file
    end
  end

end
