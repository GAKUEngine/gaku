require 'spec_helper'

describe 'Admin Disposals Course Groups' do

  stub_authorization!

  let(:course_group) { create(:course_group, is_deleted:true) }

  before do
    set_resource('course-group')
    visit gaku.course_groups_admin_disposals_path
  end

  context 'no deleted course groups' do
    before do
      
    end
    it 'shows empty table' do
      within(table) do
        page.all('tbody tr').size.should eq 0
      end
    end
  end

  context 'existing course groups', js:true do
    before do
      course_group
      visit gaku.course_groups_admin_disposals_path
    end

    it 'lists deleted course groups' do
      within(table) do
        page.all('tbody tr').size.should eq 1
      end
    end

    pending 'deteles' do
      expect do
        ensure_delete_is_working
        page.should_not have_content course_group.name
        flash_destroyed?
      end.to change(Gaku::CourseGroup,:count).by -1
    end

    it 'reverts' do
      expect do
        within(table) { click '.recovery-link' }
      end.to change(Gaku::CourseGroup,:count).by 0
    end

  end

end