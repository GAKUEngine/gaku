require 'spec_helper'

describe 'Admin Grading Method Sets' do

  as_admin

  let(:grading_method_set) { create(:grading_method_set, is_primary: true) }
  let(:grading_method_set2) { create(:grading_method_set, name: 'Set 2') }


  before :all do
    set_resource 'admin-grading-method-set'
  end

  context 'new', js: true do
    before do
      visit gaku.admin_grading_method_sets_path
      click new_link
      wait_until_visible submit
    end

    it { has_validations? }

    it 'creates and shows' do
      expect do
        fill_in 'grading_method_set_name', with: 'Bulgarian'
        click submit
        wait_until_invisible form
      end.to change(Gaku::GradingMethodSet, :count).by 1

      page.should have_content 'Bulgarian'
      within(count_div) do
        page.should have_content 'Grading Method Sets list(1)'
      end
      flash_created?
    end

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      grading_method_set
      visit gaku.admin_grading_method_sets_path
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'grading_method_set_name', with: 'Japanese'
        click submit

        wait_until_invisible modal
        page.should have_content 'Japanese'
        page.should_not have_content grading_method_set.name
        flash_updated?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

      it 'has validations' do
        fill_in 'grading_method_set_name', with: ''
        has_validations?
      end

    end

    it 'deletes', js: true do
      page.should have_content grading_method_set.name
      within(count_div) do
        page.should have_content 'Grading Method Sets list(1)'
      end

      expect do
        ensure_delete_is_working
      end.to change(Gaku::GradingMethodSet, :count).by(-1)

      within(count_div) do
        page.should_not have_content 'Grading Method Sets list(1)'
      end
      page.should_not have_content grading_method_set.name
      flash_destroyed?
    end
  end

  context 'primary' do
    before do
      grading_method_set
      grading_method_set2
      visit gaku.admin_grading_method_sets_path
    end

    it 'sets primary', js: true do
      grading_method_set.is_primary? == true
      grading_method_set2.is_primary? == false

      within("#{table} tr#grading-method-set-#{grading_method_set2.id}") do
        click_link 'set_primary_link'
      end
      accept_alert

      grading_method_set.is_primary? == false
      grading_method_set2.is_primary? == true
    end

    it 'delete primary', js: true do
      grading_method_set_tr = "#grading-method-set-#{grading_method_set.id}"
      grading_method_set2_tr = "#grading-method-set-#{grading_method_set2.id}"

      within "#{table} #{grading_method_set2_tr}" do
        click_link 'set_primary_link'
      end
      accept_alert

      page.find("#{grading_method_set2_tr} a.btn-primary.make-primary-grading-method-set")

      within "#{table} tr#grading-method-set-#{grading_method_set2.id}" do
        click delete_link
      end
      accept_alert

      page.find("#{grading_method_set_tr} a.btn-primary.make-primary-grading-method-set")

      grading_method_set.is_primary? == true
    end
  end
end
