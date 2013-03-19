require 'spec_helper'

describe 'Exam Portion Attachments' do

  as_admin

  let(:exam) { create(:exam, :name => "Unix") }
  let(:exam_portion) { create(:exam_portion, :exam => exam) }
  let(:attachment) { create(:attachment, :attachable => exam_portion) }

  before :all do
    set_resource 'exam-exam-portion-attachment'
  end

  context '#new', js: true do
    before do
      exam; exam_portion
      visit gaku.exam_exam_portion_path(exam, exam_portion)
      click new_link
      wait_until_visible submit
    end

    it 'creates and show' do
      expect do
        fill_in 'attachment_name', with: 'Attachment name'
        fill_in 'attachment_description', with: 'Attachment description'

        absolute_path = Rails.root + "../support/120x120.jpg"
        attach_file 'attachment_asset', absolute_path
        click submit
        current_path.should == gaku.exam_exam_portion_path(exam, exam_portion)
      end.to change(Gaku::Attachment, :count).by 1

      flash_uploaded?

      page.should have_content 'Attachment name'
      page.should have_content 'Attachment description'
      page.should have_content '120x120.jpg'
      page.should have_content 'image/jpeg'
    end

    it {has_validations?}

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end
  end

  context 'when exists', js: true do
    
    before do
      exam; exam_portion; attachment
      visit gaku.exam_exam_portion_path(exam, exam_portion)
    end

    it 'deletes from index table' do
      within(count_div) { page.should have_content 'Attachment list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Attachment, :count).by -1

      within(count_div) { page.should have_content 'Attachment list' }
      page.should_not have_content("#{attachment.name}")
      flash_destroyed?
    end

    context 'when deleted' do

      before do
        within(table) do
          click delete_link
          accept_alert
        end
        flash_destroyed?
      end

      it 'shows the attachment in attachment disposals' do
        visit gaku.attachments_admin_disposals_path
        page.should have_content "#{attachment.name}"
      end

      it 'deletes attachment from index table' do
        visit gaku.exam_exam_portion_path(exam, exam_portion)
        page.should_not have_content "#{attachment.name}"
      end

      it 'revert deleting' do
        visit gaku.attachments_admin_disposals_path
        page.should have_content "#{attachment.name}"
        click '.recovery-link'
        flash_recovered?
        visit gaku.exam_exam_portion_path(exam, exam_portion)
        page.should have_content "#{attachment.name}"
      end

      it 'deletes forever' do
        visit gaku.attachments_admin_disposals_path
        page.should have_content "#{attachment.name}"
        click delete_link
        accept_alert
        flash_destroyed?
        page.should_not have_content "#{attachment.name}"
        
        visit gaku.attachments_admin_disposals_path
        page.should_not have_content "#{attachment.name}"
        visit gaku.exam_exam_portion_path(exam, exam_portion)
        page.should_not have_content "#{attachment.name}"
      end
    end

  end

end