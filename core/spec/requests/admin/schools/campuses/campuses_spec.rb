require 'spec_helper'

describe 'Admin School Campuses' do

  before { as :admin }

  let(:school) { create(:school, name:'Nagoya University') }
  let(:campus) { create(:campus ) }

  before :all do
    set_resource 'admin-school-campus'
  end

  before do
    visit gaku.edit_admin_school_path(school)
  end

  context 'new', js: true do
    before do
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      within(count_div) { page.should have_content 'Campuses list(1)' }

      expect do
        fill_in 'campus_name', with: 'Nagoya Campus'
        click submit
        wait_until_invisible form
      end.to change(school.campuses, :count).by 1

      page.should have_content 'Nagoya Campus'
      within(count_div) { page.should have_content 'Campuses list(2)' }
      flash_created?
    end

  end

  context 'existing', js: true do
    before do
      campus
      visit gaku.edit_admin_school_path(school)
    end

    context 'edit' do
      xit 'edits' do
        click edit_link
        fill_in 'campus_name', with: 'Nagoya Campus'
        click submit

        within(table) do
          page.should have_content 'Nagoya Campus'
          page.should_not have_content 'Nagoya University'
        end
        flash_updated?
      end
    end

    it 'shows' do
      within(table) { click show_link }
      page.should have_content 'Contacts list'
    end

  end

end
