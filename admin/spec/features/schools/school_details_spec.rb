require 'spec_helper'

describe 'Admin School Details' do

  let(:school) { create(:school, primary: true) }
  let(:school_with_picture) { create(:school, primary: true,  picture: uploaded_file('120x120.jpg')) }

  before { as :admin }

  context 'without picture' do
    before do
      school
      visit gaku.admin_school_details_edit_path
    end

    it 'upload avatar', js: true do
      click '#avatar-picture'
      expect do
        attach_file :school_picture, File.join(Rails.root + '../support/120x120.jpg')
        click_button 'Upload'
        wait_for_ajax
        school.reload
        flash_updated?
      end.to change(school, :picture_content_type).from(nil).to('image/jpeg')
    end
  end

  context 'with picture' do
    before do
      school_with_picture
      visit gaku.admin_school_details_edit_path
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
      school_with_picture.reload
      expect(school_with_picture.picture).to_not be_file
    end
  end
end
