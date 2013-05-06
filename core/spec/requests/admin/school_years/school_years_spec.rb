require 'spec_helper'

describe 'Admin School Years' do

  let(:school_year) { create(:school_year)}

  as_admin

  before :all do
    set_resource "admin-school-year"
  end

  context 'new', :js => true do
    before do
      visit gaku.admin_school_years_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'school_year_starting', :with => '2013-04-08'
        fill_in 'school_year_ending', :with => '2014-04-08'
        click submit
        wait_until_invisible form
      end.to change(Gaku::SchoolYear, :count).by(1)

      within(count_div) { page.should have_content 'School Years list(1)' }
      flash_created?
    end
    context 'validations' do

      it 'has ending after starting validation' do
        fill_in 'school_year_starting', :with => Date.parse('2013-3-8')
        fill_in 'school_year_ending', :with => Date.parse('2013-3-8')
        click submit
        page.should have_content 'The Ending Date must come after the Starting Date'

        fill_in 'school_year_starting', :with => Date.parse('2013-3-8')
        fill_in 'school_year_ending', :with => Date.parse('2013-3-9')
        click submit
        page.should_not have_content 'The Ending Date must come after the Starting Date'
        flash_created?
      end


      it 'has validations' do
        fill_in 'school_year_starting', :with => ''
        fill_in 'school_year_ending', :with => ''
        has_validations?
      end
    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      school_year
      visit gaku.admin_school_years_path
    end

    context 'edit', :js => true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'school_year_starting', :with => '2013-10-08'
        fill_in 'school_year_ending', :with => '2014-10-09'

        click submit

        wait_until_invisible modal
        page.should have_content '2013 October 08'
        page.should have_content '2014 October 09'

        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end

      context 'validations' do
        it "validate ending before starting" do
          fill_in 'school_year_starting', :with => Date.parse('2013-3-8')
          fill_in 'school_year_ending', :with => Date.parse('2013-3-8')
          click submit
          page.should have_content 'The Ending Date must come after the Starting Date'

          fill_in 'school_year_starting', :with => Date.parse('2013-3-8')
          fill_in 'school_year_ending', :with => Date.parse('2013-3-9')
          click submit
          page.should_not have_content 'The Ending Date must come after the Starting Date'
          flash_updated?
        end

        it 'has validations' do
          fill_in 'school_year_starting', :with => ''
          fill_in 'school_year_ending', :with => ''
          has_validations?
        end

      end

      it 'deletes', :js => true do
        within(count_div) { page.should have_content 'School Years list(1)' }
        expect do
          ensure_delete_is_working
        end.to change(Gaku::SchoolYear, :count).by -1

        within(count_div) { page.should_not have_content 'School Years list(1)' }
        within(count_div) { page.should have_content 'School Years list' }
        flash_destroyed?
    end


    end
  end

end