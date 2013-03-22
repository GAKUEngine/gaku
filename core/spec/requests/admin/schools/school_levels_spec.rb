require 'spec_helper'

describe 'Admin School Levels' do

  let(:school) { create(:school) }
  let(:master_school) { create(:school, :master, :name => 'Asenovgrad University')}
  let(:school_level) { create(:school_level, :school => master_school)}
  as_admin

  before :all do
    set_resource 'admin-school'
  end

  context 'new', :js => true do
    before do
      master_school
      visit gaku.admin_school_details_path
    end

    it 'create and show' do
      click '#edit-admin-primary-school'
      accept_alert
      current_path.should == gaku.admin_school_details_edit_path
      click '.add-school-level'
      fill_in 'School Level', :with => '12 class'
      click submit
      flash_updated?
      visit gaku.admin_school_details_path
      page.should have_content('12 class')
    end
  end

  context 'deletes', :js => true do
    before do
      school_level
      master_school
      visit gaku.admin_school_details_path
      click '#edit-admin-primary-school'
      accept_alert
      current_path.should == gaku.admin_school_details_edit_path
    end

    it "edit" do
      click '.remove-school-level'
      click submit
      flash_updated?
      visit gaku.admin_school_details_path
      page.should_not have_content(school_level.title)
    end

    it "delete" do
      fill_in 'School Level', :with => '5 class'
      click submit
      flash_updated?
      visit gaku.admin_school_details_path
      page.should_not have_content(school_level.title)
      page.should have_content('5 class')
    end
  end

  context 'non master schools should not edit and show school levels', :js => true do
    before do
      school
      master_school
      school_level
      visit gaku.admin_schools_path
    end

    it "have no edit for school levels" do
      within(table) { click edit_link }
      page.should_not have_css('a.add-school-level')
    end

    it "not show school levels on non primary school" do
      within(table) { click show_link }
      page.should_not have_content('School Levels')
      page.should_not have_content(school_level.title)
    end
  end

end