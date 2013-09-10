require 'spec_helper'

describe 'Admin Commute Method Types' do

  before { as :admin }
  before(:all) { set_resource 'admin-commute-method-type' }

  let(:commute_method_type) { create(:commute_method_type, name: 'metro') }

  context 'new', js: true do
  	before do
  	  visit gaku.admin_commute_method_types_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'commute_method_type_name', with: 'car'
        click submit
        flash_created?
      end.to change(Gaku::CommuteMethodType, :count).by(1)

      has_content? 'car'
      count? 'Commute Method Types list(1)'
    end

    it { has_validations? }

  end

  context 'existing' do

    before do
      commute_method_type
      visit gaku.admin_commute_method_types_path
    end

    context '#edit ', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'has validations' do
        fill_in 'commute_method_type_name', with: ''
        has_validations?
      end

    	it 'edits' do
    	  fill_in 'commute_method_type_name', with: 'car'
    	  click submit

    	  flash_updated?
    	  has_content? 'car'
    	  has_no_content? 'metro'
        expect(commute_method_type.reload.name).to eq 'car'
    	end
    end

    it 'deletes', js: true do
      has_content? commute_method_type.name
      count? 'Commute Method Types list(1)'

      expect do
        ensure_delete_is_working
      end.to change(Gaku::CommuteMethodType, :count).by(-1)

      flash_destroyed?
      count? 'Commute Method Types list(1)'
      has_content? commute_method_type.name
    end

  end
end
