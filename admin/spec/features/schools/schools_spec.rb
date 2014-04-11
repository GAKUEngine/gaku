require 'spec_helper'

describe 'Admin Schools' do

  before(:all) { set_resource 'admin-school' }
  before { as :admin }

  let(:school) { create(:school, name: 'Varna Technical University') }

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#schools-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'school_name', with: 'Nagoya University'
        click submit
        flash_created?
      end.to change(Gaku::School, :count).by 1

      has_content? 'Nagoya University'
      count? 'Schools list(1)'
    end

    it { has_validations? }
  end


  context 'existing', js: true do

    before do
      school
      visit gaku.admin_root_path
      click '#schools-menu a'
    end

    context 'edit' do

      before { within(table) { click edit_link } }

      it 'edits'  do
        fill_in 'school_name', with: 'Sofia Technical University'
        click submit

        flash_updated?
        has_content? 'Sofia Technical University'
        has_no_content? 'Varna Technical University'
      end

      it 'has validations' do
        fill_in 'school_name', with: ''
        has_validations?
      end

    end

    xit 'deletes' do
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
