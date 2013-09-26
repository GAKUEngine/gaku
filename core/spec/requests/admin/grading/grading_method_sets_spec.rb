require 'spec_helper'

describe 'Admin Grading Method Sets' do

  before { as :admin }
  before(:all) { set_resource 'admin-grading-method-set' }

  let(:grading_method_set) { create(:grading_method_set, name: 'Set 1', primary: true) }

  context 'new', js: true do
    before do
      visit gaku.admin_grading_method_sets_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'grading_method_set_name', with: 'Bulgarian'
        page.has_css? '#grading_method_set_display_deviation'
        page.has_css? '#grading_method_set_display_rank'
        page.has_css? '#grading_method_set_rank_order'
        click submit
        flash_created?
      end.to change(Gaku::GradingMethodSet, :count).by 1

      has_content? 'Bulgarian'
      count? 'Grading Method Sets list(1)'
    end

    it { has_validations? }
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

        flash_updated?
        has_content? 'Japanese'
        has_no_content? 'Set 1'
        expect(grading_method_set.reload.name).to eq 'Japanese'
      end

      it 'has validations' do
        fill_in 'grading_method_set_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? grading_method_set.name
      count? 'Grading Method Sets list(1)'

      expect do
        ensure_delete_is_working
      end.to change(Gaku::GradingMethodSet, :count).by(-1)

      flash_destroyed?
      has_no_content? grading_method_set.name
    end
  end

  context 'primary' do
    let(:grading_method_set2) { create(:grading_method_set, name: 'Set 2') }

    before do
      grading_method_set
      grading_method_set2
      visit gaku.admin_grading_method_sets_path
    end

    it 'sets primary', js: true do
      grading_method_set.primary? == true
      grading_method_set2.primary? == false

      within("#{table} tr#grading-method-set-#{grading_method_set2.id}") do
        click_link 'set_primary_link'
      end
      accept_alert

      grading_method_set.primary? == false
      grading_method_set2.primary? == true
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

      grading_method_set.primary? == true
    end
  end
end
