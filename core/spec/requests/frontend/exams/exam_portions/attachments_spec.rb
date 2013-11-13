require 'spec_helper'

describe 'Exam Portion Attachments' do

  before(:all) { set_resource 'exam-exam-portion-attachment' }
  before { as :admin }

  let(:exam) { create(:exam, name: 'Unix') }
  let(:exam_portion) { create(:exam_portion, exam: exam) }
  let(:attachment) { create(:attachment, attachable: exam_portion) }

  context '#new', js: true do
    before do
      exam; exam_portion
      visit gaku.edit_exam_exam_portion_path(exam, exam_portion)
      click new_link
      wait_until_visible submit
    end

    it 'creates and show' do
      expect do
        fill_in 'attachment_name', with: 'Attachment name'
        fill_in 'attachment_description', with: 'Attachment description'

        absolute_path = Rails.root + '../support/120x120.jpg'
        attach_file 'attachment_asset', absolute_path
        click submit
        flash_created?
      end.to change(Gaku::Attachment, :count).by 1

      has_content? 'Attachment name'
      has_content? 'Attachment description'
      has_content? '120x120.jpg'
      has_content? 'image/jpeg'
    end

    it { has_validations? }

  end

  context 'when exists', js: true do

    before do
      exam; exam_portion; attachment
      visit gaku.edit_exam_exam_portion_path(exam, exam_portion)
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        page.should have_content attachment.name

        fill_in 'attachment_name', with: 'Different name'
        fill_in 'attachment_description', with: 'Different description'

        click submit

        flash_updated?
        within(table) do
          has_content? 'Different name'
          has_no_content? attachment.name
        end
      end

      it 'has validations' do
        fill_in 'attachment_name', with: ''
        has_validations?
      end
    end

    it 'deletes from index table' do
      within(count_div) { page.should have_content 'Attachments list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Attachment, :count).by -1

      within(count_div) { page.should have_content 'Attachments list' }
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
