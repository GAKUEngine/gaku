require 'spec_helper'

describe 'Admin School Levels' do

  before { as :admin }

  let(:school) { create(:school) }
  let(:master_school) { create(:school, primary: true, name: 'Asenovgrad University') }
  let(:master_school_level) { create(:level, school: master_school) }
  let(:school_level) { create(:level, school: school) }

  before(:all) { set_resource 'admin-school' }

  context 'new', js: true do
    before do
      master_school
      visit gaku.admin_root_path
      click '#schools-menu a'
    end

    it 'create and show' do
      click '#edit-admin-primary-school'
      accept_alert
      click '.add-school-level'
      fill_in 'School Level', with: '12 class'
      click submit
      flash_updated?
    end
  end

  context 'deletes', js: true do
    before do
      master_school
      master_school_level
      visit gaku.admin_root_path
      click '#schools-menu a'
      click '#edit-admin-primary-school'
      accept_alert
    end

    it 'edit' do
      click '.remove-school-level'
      click submit
      flash_updated?
      visit gaku.admin_root_path
      click '#schools-menu a'
      page.should_not have_content master_school_level
    end

    it 'deletes' do
      fill_in 'School Level', with: '5 class'
      click submit
      flash_updated?
      visit gaku.admin_school_details_edit_path
      page.should_not have_content master_school_level
      expect(find('.school-level-name').value).to eq '5 class'
    end
  end

  context 'non master schools should not edit school levels', js: true do
    before do
      school
      school_level
      visit gaku.admin_root_path
      click '#schools-menu a'
    end

    it 'have no edit for school levels' do
      within(table) { click edit_link }
      page.should_not have_css 'a.add-school-level'
    end
  end

end
