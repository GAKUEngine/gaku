require 'spec_helper'

describe 'Admin Grading Methods' do

  before { as :admin }
  before(:all) { set_resource 'admin-grading-method' }

  let(:grading_method) { create(:grading_method, name: 'Bulgarian',
                        arguments: {"A" => 95, "B" => 85 } ) }


  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#grading-methods-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'grading_method_name', with: 'Bulgarian'
        find('input.dynamicAttributeName').set 'A'
        find('input.dynamicAttributeValue').set 85
        click submit
        flash_created?
      end.to change(Gaku::GradingMethod, :count).by 1

      has_content? 'Bulgarian'
      count? 'Grading Methods list(1)'
      expect(Gaku::GradingMethod.last.arguments).to eq({"A"=>"85"})
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      grading_method
      visit gaku.admin_root_path
      click '#grading-methods-menu a'
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'grading_method_name', with: 'Japanese'
        all(:css, 'input.dynamicAttributeName').first.set 'C'
        click submit

        flash_updated?
        has_content? 'Japanese'
        has_no_content? 'Bulgarian'
        grading_method.reload
        expect(grading_method.name).to eq 'Japanese'
        expect(grading_method.reload.arguments).to eq({'C' => '95', 'B' => '85'})
      end

      it 'add arguments' do
        click '.add-argument-row'
        all(:css, 'input.dynamicAttributeName').last.set 'C'
        all(:css, 'input.dynamicAttributeValue').last.set '75'

        click submit

        flash_updated?
        expect(grading_method.reload.arguments).to eq({'A' => '95', 'B' => '85', 'C' => '75'})
      end

      it 'remove arguments' do
        all(:css, ".remove-argument-row").first.click
        accept_alert
        click submit

        flash_updated?
        expect(grading_method.reload.arguments).to eq({"B" => '85'})
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
