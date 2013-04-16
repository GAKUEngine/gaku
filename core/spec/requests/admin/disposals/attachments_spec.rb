require 'spec_helper'

describe 'Admin Disposals Attachments' do

  as_admin

  let(:attachment) { create(:attachment, :for_exam_portion, :is_deleted => 1) }

  before do
    set_resource('disposal-attachment')
    visit gaku.attachments_admin_disposals_path
    #table = page.find('.disposals-attachment-index')
  end

  context 'no deleted attachment' do
    before do

    end
    it 'shows empty table' do
      within(table) do
        page.all('tbody tr').size.should eq 0
      end
    end
  end

  context 'existing attachment', js:true do
    before do
      attachment
      visit gaku.attachments_admin_disposals_path
    end

    it 'lists deleted attachment' do
      within(table) do
        page.all('tbody tr').size.should eq 1
      end
    end

    it 'deteles' do
      expect do
        ensure_delete_is_working
      end.to change(Gaku::Attachment.unscoped,:count).by -1

      page.should_not have_content attachment.name
      flash_destroyed?
    end

    it 'recovery' do
      expect do
        within(table) { click '.recovery-link' }
      end.to change(Gaku::Attachment,:count).by 0

      page.should_not have_content attachment.name
      flash_recovered?
    end

  end

end
