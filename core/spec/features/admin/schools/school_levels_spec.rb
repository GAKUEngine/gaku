require 'spec_helper'

describe 'Admin School Levels' do

  before { as :admin }

  let(:school) { create(:school) }
  let(:master_school) { create(:school, :master, name: 'Asenovgrad University') }
  let(:master_school_level) { create(:level, school: master_school) }
  let(:school_level) { create(:level, school: school) }

  before :all do
    set_resource 'admin-school'
  end

  context 'new', js: true do
    before do
      master_school
      visit gaku.admin_school_details_path
    end

    it 'create and show' do
      click '#edit-admin-primary-school'
      accept_alert
      page.should have_content 'Edit Master School'
      click '.add-school-level'
      fill_in 'School Level', with: '12 class'
      click submit
      flash_updated?
      visit gaku.admin_school_details_path
      page.should have_content '12 class'
    end
  end

  context 'deletes', js: true do
    before do
      master_school
      master_school_level
      visit gaku.admin_school_details_path
      click '#edit-admin-primary-school'
      accept_alert
    end

    it 'edit' do
      click '.remove-school-level'
      click submit
      flash_updated?
      visit gaku.admin_school_details_path
      page.should_not have_content master_school_level
    end

    it 'delete' do
      fill_in 'School Level', with: '5 class'
      click submit
      flash_updated?
      visit gaku.admin_school_details_path
      page.should_not have_content master_school_level
      page.should have_content '5 class'
    end
  end

  context 'non master schools should not edit and show school levels', js: true do
    before do
      school
      school_level
      visit gaku.admin_schools_path
    end

    it 'have no edit for school levels' do
      within(table) { click edit_link }
      page.should_not have_css 'a.add-school-level'
    end

    it 'not show school levels on non primary school' do
      within(table) { click show_link }
      page.should_not have_content 'School Levels'
    end
  end

end
