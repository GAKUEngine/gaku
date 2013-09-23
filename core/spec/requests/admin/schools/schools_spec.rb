require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Admin Schools' do

  before { as :admin }

  let(:school) { create(:school, name: 'Varna Technical University') }

  before :all do
    set_resource "admin-school"
  end

  context 'new', js: true do
    before do
      visit gaku.admin_schools_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'school_name', with: 'Nagoya University'
        click submit

        wait_until_invisible form
      end.to change(Gaku::School, :count).by 1

      page.should have_content 'Nagoya University'
      within(count_div) { page.should have_content 'Schools list(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end

    it { has_validations? }
  end

  context 'shows primary school avatar' do

    before do
      primary_school = create(:school, primary:true)
      visit gaku.admin_schools_path
      @file_name = 'school_picture'
    end

    it_behaves_like 'new avatar'

  end
  context 'existing', js: true do

    before do
      school
      visit gaku.admin_schools_path
    end

    context 'edit' do

      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits'  do
        fill_in 'school_name', with: 'Sofia Technical University'
        click submit

        wait_until_invisible modal
        page.should have_content 'Sofia Technical University'
        page.should_not have_content 'Varna Technical University'
        flash_updated?
      end

      it 'cancels editting' do
        ensure_cancel_modal_is_working
      end

      it 'has validations' do
        fill_in 'school_name', with: ''
        has_validations?
      end

    end

    it 'shows' do
      within(table) { click show_link }
      page.should have_content 'School Show'
      current_path.should eq "/admin/schools/#{school.id}"
    end

    context '#edit from show' do
      show_table  = '#school-show-table'

      before do
        visit gaku.admin_school_path(school)
        click_on "Edit"
        wait_until_visible modal
      end

      it 'has validations' do
        fill_in 'school_name', with: ''
        has_validations?
      end

      it 'edits', js: true do
        fill_in 'school_name', with: 'Sofia Technical University'
        click submit

        wait_until_invisible modal

        find(show_table).should have_content 'Sofia Technical University'
        find(show_table).should_not have_content 'Varna Technical University'
        flash_updated?
      end

      it 'cancels editting' do
        ensure_cancel_modal_is_working
      end
    end


    it 'deletes' do
      within(count_div) { page.should have_content 'Schools list(1)' }
      page.should have_content school.name

      expect do
        ensure_delete_is_working
      end.to change(Gaku::School, :count).by -1

      within(count_div) { page.should_not have_content 'Schools list(1)' }
      page.should_not have_content school.name
      flash_destroyed?
    end
  end

end
