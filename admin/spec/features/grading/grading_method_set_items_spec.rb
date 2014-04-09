require 'spec_helper'

describe 'Admin Grading Method Set Items' do

  before { as :admin }

  before :all do
    set_resource 'admin-grading-method-set-grading-method-set-item'
  end

  let(:grading_method_set) { create(:grading_method_set) }
  let!(:grading_method) { create(:grading_method, name: 'Bulgarian') }
  let!(:grading_method2) { create(:grading_method, name: 'Japanese') }

  let(:grading_method_set_item) do
    create(:grading_method_set_item, grading_method: grading_method,
                                     grading_method_set: grading_method_set)
  end

  context 'new', js: true do
    before do
      grading_method_set
      visit gaku.admin_root_path
      click '#grading-method-sets-menu a'
      click '.show-link'
      #visit gaku.admin_grading_method_set_path(grading_method_set)
      click new_link
    end

    it 'creates and shows' do
      expect do
        select grading_method.name, from: 'grading_method_set_item_grading_method_id'
        click submit
        flash_created?
      end.to change(Gaku::GradingMethodSetItem, :count).by(1)

      within(table) { has_content? 'Bulgarian' }
      count? 'Grading Methods list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      grading_method2
      grading_method_set
      grading_method_set_item
      visit gaku.admin_root_path
      click '#grading-method-sets-menu a'
      click '.show-link'
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        select grading_method2.name, from: 'grading_method_set_item_grading_method_id'
        click submit

        flash_updated?
        within(table) { has_no_content? 'Bulgarian' }
        within(table) { has_content? 'Japanese' }
        expect(grading_method_set_item.reload.grading_method).to eq grading_method2
      end

      it 'has validations' do
        #select '', from: 'grading_method_set_item_grading_method_id'
        has_validations?
      end

    end

    it 'deletes', js: true do
      within(table) { have_content? grading_method.name }
      count? 'Grading Methods list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::GradingMethodSetItem, :count).by(-1)


      within(table) { has_no_content? grading_method.name }
    end

  end
end
