require 'spec_helper'

describe 'Admin School Years Semesters' do

  let(:school_year) { create(:school_year, starting: Date.parse('2013-3-8'), ending: Date.parse('2014-11-8')) }
  let(:semester) { create(:semester, school_year: school_year)}

  before { as :admin }
  before(:all) { set_resource 'admin-school-year-semester' }

  context 'new', js: true do
    before do
      school_year
      visit gaku.admin_root_path
      click '#school-years-menu a'
      click edit_link
      click '#semesters-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'semester_starting', with: '2013-04-08'
        fill_in 'semester_ending', with: '2014-04-08'
        click submit
        flash_created?
      end.to change(Gaku::Semester, :count).by(1)

      within(count_div) { page.should have_content 'Semesters list(1)' }
    end

    context 'validations' do
      it 'has ending after starting validation' do
        fill_in 'semester_starting', with: Date.parse('2013-3-8')
        fill_in 'semester_ending', with: Date.parse('2013-3-8')
        click submit
        page.should have_content 'The Ending Date must come after the Starting Date'

        fill_in 'semester_starting', with: Date.parse('2013-3-8')
        fill_in 'semester_ending', with: Date.parse('2013-3-9')
        click submit
        page.should_not have_content 'The Ending Date must come after the Starting Date'
        flash_created?
      end

      it 'semester should be beetween school year starting and ending' do
        fill_in 'semester_starting', with: Date.parse('2013-3-7')
        fill_in 'semester_ending', with: Date.parse('2014-11-9')
        click submit
        page.should have_content 'Should be between School Year starting and ending'

        fill_in 'semester_starting', with: Date.parse('2013-3-8')
        fill_in 'semester_ending', with: Date.parse('2013-3-9')
        click submit
        page.should_not have_content 'Should be between School Year starting and ending'
        flash_created?
      end

      it 'presence validations'  do
        fill_in 'semester_ending', with: ''
        fill_in 'semester_ending', with: ''
        has_validations?
      end

    end
  end

  context 'existing' do
    before do
      school_year
      semester
      visit gaku.admin_root_path
      click '#school-years-menu a'
      click edit_link
      click '#semesters-menu a'
    end


    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'semester_starting', with: '2013-10-08'
        fill_in 'semester_ending', with: '2014-10-09'

        click submit

        page.should have_content '2013 October 08'
        page.should have_content '2014 October 09'

        flash_updated?
      end

      context 'validations' do
        it 'has ending after starting validation' do
          fill_in 'semester_starting', with: Date.parse('2013-3-8')
          fill_in 'semester_ending', with: Date.parse('2013-3-8')
          click submit
          page.should have_content 'The Ending Date must come after the Starting Date'

          fill_in 'semester_starting', with: Date.parse('2013-3-8')
          fill_in 'semester_ending', with: Date.parse('2013-3-9')
          click submit
          page.should_not have_content 'The Ending Date must come after the Starting Date'
          flash_updated?
        end

        it 'semester should be beetween school year starting and ending' do
          fill_in 'semester_starting', with: Date.parse('2013-3-7')
          fill_in 'semester_ending', with: Date.parse('2014-11-9')
          click submit
          page.should have_content 'Should be between School Year starting and ending'

          fill_in 'semester_starting', with: Date.parse('2013-3-8')
          fill_in 'semester_ending', with: Date.parse('2013-3-9')
          click submit
          page.should_not have_content 'Should be between School Year starting and ending'
          flash_updated?
        end

        it 'presence validations'  do
          fill_in 'semester_ending', with: ''
          fill_in 'semester_ending', with: ''
          has_validations?
        end

      end
    end

    it 'deletes', js: true do
      within(count_div) { page.should have_content 'Semesters list(1)' }

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Semester, :count).by -1

      within(count_div) { page.should_not have_content 'Semesters list(1)' }
      within(count_div) { page.should have_content 'Semesters list' }
    end
  end

end