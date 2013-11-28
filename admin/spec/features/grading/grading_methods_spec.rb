require 'spec_helper'

describe 'Admin Grading Methods' do

  before { as :admin }
  before(:all) { set_resource 'admin-grading-method' }

  let(:grading_method) { create(:grading_method, name: 'Bulgarian') }


  context 'new', js: true do
    before do
      visit gaku.admin_grading_methods_path
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'grading_method_name', with: 'Bulgarian'
        click submit
        flash_created?
      end.to change(Gaku::GradingMethod, :count).by 1

      has_content? 'Bulgarian'
      count? 'Grading Methods list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      grading_method
      visit gaku.admin_grading_methods_path
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'grading_method_name', with: 'Japanese'
        click submit

        flash_updated?
        has_content? 'Japanese'
        has_no_content? 'Bulgarian'
        expect(grading_method.reload.name).to eq 'Japanese'
      end

      it 'has validations' do
        fill_in 'grading_method_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? grading_method.name
      count? 'Grading Methods list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::GradingMethod, :count).by -1


      count? 'Grading Methods list(1)'
      has_content? grading_method.name
    end

  end
end
