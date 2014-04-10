# require 'spec_helper'

# describe 'Student Guardian Picture' do

#   let(:student) { create(:student) }
#   let(:guardian) { create(:guardian) }

#   before do
#     as :admin
#     @file_name = 'guardian_picture'
#     student.guardians << guardian
#   end

#   context 'upload avatar' do
#     before { visit gaku.edit_student_guardian_path(student, guardian) }
#     it_behaves_like 'upload avatar'
#   end

#   context 'show avatar' do
#     before { visit gaku.edit_student_guardian_path(student, guardian) }
#     it_behaves_like 'show avatar'
#   end

# end



require 'spec_helper'

describe 'Student Guardian Picture' do

   let(:student) { create(:student) }
   let(:guardian) { create(:guardian) }
   let(:guardian_with_picture) { create(:guardian,
    picture: ActionDispatch::Http::UploadedFile.new(:tempfile => File.new("#{Rails.root}/../support/120x120.jpg"), :filename => "120x120.jpg")
    )}

  before do
    as :admin
  end

  context 'without picture' do
    before do
      student.guardians << guardian
      visit gaku.edit_student_guardian_path(student, guardian)
    end


    it 'upload avatar', js: true do
      click '#avatar-picture'
      expect do
      attach_file :guardian_picture,
              File.join(Rails.root + '../support/120x120.jpg')
      click_button 'Upload'
      wait_for_ajax
      guardian.reload
      flash_updated?
      end.to change(guardian, :picture_content_type).from(nil).to('image/jpeg')
    end
  end

  context 'with picture' do
    before do
      student.guardians << guardian_with_picture
      visit gaku.edit_student_guardian_path(student, guardian_with_picture)
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
      guardian_with_picture.reload
      expect(guardian_with_picture.picture).to_not be_file
    end
  end

end
