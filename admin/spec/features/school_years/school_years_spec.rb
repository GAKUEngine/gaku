require 'spec_helper'

describe 'Admin School Years' do

  let(:school_year) { create(:school_year)}

  before { as :admin }

  before :all do
    set_resource 'admin-school-year'
  end

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#school-years-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'school_year_starting', with: '2013-04-08'
        fill_in 'school_year_ending', with: '2014-04-08'
        click submit
        flash_created?
      end.to change(Gaku::SchoolYear, :count).by(1)

      within(count_div) { page.should have_content 'School Years list(1)' }
    end

    context 'validations' do

      it 'has ending after starting validation' do
        fill_in 'school_year_starting', with: Date.parse('2013-3-8')
        fill_in 'school_year_ending', with: Date.parse('2013-3-8')
        click submit
        page.should have_content 'The Ending Date must come after the Starting Date'

        fill_in 'school_year_starting', with: Date.parse('2013-3-8')
        fill_in 'school_year_ending', with: Date.parse('2013-3-9')
        click submit
        page.should_not have_content 'The Ending Date must come after the Starting Date'
        flash_created?
      end


      it 'has validations' do
        fill_in 'school_year_starting', with: ''
        fill_in 'school_year_ending', with: ''
        has_validations?
      end
    end

  end

  context 'existing' do
    before do
      school_year
      visit gaku.admin_root_path
      click '#school-years-menu a'
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        fill_in 'school_year_starting', with: '2013-10-08'
        fill_in 'school_year_ending', with: '2014-10-09'

        click submit

        flash_updated?

        find_field('school_year_starting').value.should eq '2013-10-08'
        find_field('school_year_ending').value.should eq '2014-10-09'
      end

      context 'validations' do
        it 'validate ending before starting' do
          fill_in 'school_year_starting', with: Date.parse('2013-3-8')
          fill_in 'school_year_ending', with: Date.parse('2013-3-8')
          click submit
          page.should have_content 'The Ending Date must come after the Starting Date'

          fill_in 'school_year_starting', with: Date.parse('2013-3-8')
          fill_in 'school_year_ending', with: Date.parse('2013-3-9')
          click submit
          page.should_not have_content 'The Ending Date must come after the Starting Date'
          flash_updated?
        end

        it 'has validations' do
          fill_in 'school_year_starting', with: ''
          fill_in 'school_year_ending', with: ''
          has_validations?
        end

      end
    end

    it 'deletes', js: true do
      within(count_div) { page.should have_content 'School Years list(1)' }
      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::SchoolYear, :count).by -1

      within(count_div) { page.should_not have_content 'School Years list(1)' }
      within(count_div) { page.should have_content 'School Years list' }

    end
  end

end