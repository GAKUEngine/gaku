require 'spec_helper'

describe 'Admin School Campuses' do

  before { as :admin }

  let(:school) { create(:school, name: 'Nagoya University') }
  let(:campus) { create(:campus) }

  before(:all) { set_resource 'admin-school-campus' }

  before do
    visit gaku.edit_admin_school_path(school)
    click '#campuses-menu a'
  end

  context 'new', js: true do
    before do
      click new_link
    end

    it 'creates and shows' do
      within(count_div) { page.should have_content 'Campuses list(1)' }

      expect do
        fill_in 'campus_name', with: 'Nagoya Campus'
        click submit
        flash_created?
      end.to change(school.campuses, :count).by 1

      page.should have_content 'Nagoya Campus'
      within(count_div) { page.should have_content 'Campuses list(2)' }
    end

  end

  context 'existing', js: true do
    before do
      campus
      visit gaku.edit_admin_school_campus_path(school, campus)
    end

    context 'edit' do
      it 'edits' do
        fill_in 'campus_name', with: 'Varna Campus'
        click submit

        flash_updated?
        expect(school.reload.master_campus.name).to eq 'Varna Campus'
        expect(find_field('campus_name').value).to eq 'Varna Campus'
        page.has_content? 'Varna Campus'
      end
    end

  end
end
