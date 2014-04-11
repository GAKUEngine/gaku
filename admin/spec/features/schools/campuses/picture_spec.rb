require 'spec_helper'

describe 'Admin School Campus Picture' do

  let(:school) { create(:school) }
  let(:campus) { create(:campus, school: school) }
  let(:campus_with_picture) { create(:campus, school: school,
    picture: ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/../support/120x120.jpg"), :filename => "120x120.jpg")
    )}

  before do
    as :admin
  end

  context 'without picture' do
    before do
      visit gaku.edit_admin_school_campus_path(school, campus)
    end

    it 'upload avatar', js: true do
      click '#avatar-picture'
      expect do
      attach_file :campus_picture,
              File.join(Rails.root + '../support/120x120.jpg')
      click_button 'Upload'
      wait_for_ajax
      campus.reload
      flash_updated?
      end.to change(campus, :picture_content_type).from(nil).to('image/jpeg')
    end
  end

  context 'with picture' do
    before do
      visit gaku.edit_admin_school_campus_path(school, campus_with_picture)
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
      campus_with_picture.reload
      expect(campus_with_picture.picture).to_not be_file
    end
  end

end
