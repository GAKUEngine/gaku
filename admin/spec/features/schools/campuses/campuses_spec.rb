require 'spec_helper'

describe 'Admin School Campuses' do

  let(:school) { create(:school, name: 'Nagoya University') }
  let(:campus) { create(:campus) }

  before(:all) { set_resource 'admin-school-campus' }

  before do
    as :admin
    visit gaku.edit_admin_school_path(school)
    click '#campuses-menu a'
  end

  context 'new', js: true do
    before { click new_link }

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

    it { has_validations? }

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
        expect(campus.reload.name).to eq 'Varna Campus'
        expect(find_field('campus_name').value).to eq 'Varna Campus'
        within('#campus-name') { expect(page.has_content?('Varna Campus')).to eq true }
      end

      it 'has validations' do
        fill_in 'campus_name', with: ''
        has_validations?
      end
    end

  end
end
