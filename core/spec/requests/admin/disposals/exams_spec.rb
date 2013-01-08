require 'spec_helper'

describe 'Admin Disposals Exams' do

  stub_authorization!

  let(:syllabus) { create(:syllabus) }
  let(:exam) { create(:exam, is_standalone: true ) }

  before do
    set_resource('exam')
    visit gaku.exams_admin_disposals_path
  end

  context 'no deleted exams' do
    before do
      
    end
    it 'shows empty table' do
      within(table) do
        page.all('tbody tr').size.should eq 0
      end
    end
    it 'shows no exam info' do
      page.should have_content 'No Exam, assign one first'
    end

  end

  context 'existing exams', js:true do
    before do
      exam
      visit gaku.exams_admin_disposals_path
    end

    pending 'lists deleted exams' do
      within(table) do
        page.all('tbody tr').size.should eq 1
      end
    end

    pending 'deteles' do
      expect do
        ensure_delete_is_working
        page.should_not have_content exam.name
        flash_destroyed?
      end.to change(Gaku::Exam,:count).by -1
    end

    pending 'reverts' do
      expect do
        within(table) { click '.recovery-link' }
      end.to change(Gaku::Exam,:count).by 0
    end

  end

end