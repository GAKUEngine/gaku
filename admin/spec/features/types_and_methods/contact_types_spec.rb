require 'spec_helper'

describe 'Admin Contact Types' do

  before { as :admin }
  before(:all) { set_resource 'admin-contact-type' }

  let(:contact_type) { create(:contact_type, name: 'mobile') }

  context 'new', js: true do
    before do
      visit gaku.admin_root_path
      click '#contact-types-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'contact_type_name', with: 'home phone'
        click submit
        flash_created?
      end.to change(Gaku::ContactType, :count).by 1

      has_content? 'home phone'
      count? 'Contact Types list(1)'
    end

    it { has_validations? }

  end

  context 'existing' do
    before do
      contact_type
      visit gaku.admin_root_path
      click '#contact-types-menu a'
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        fill_in 'contact_type_name', with: 'email'
        click submit

        flash_updated?
        has_content? 'email'
        has_no_content? 'mobile'
        expect(contact_type.reload.name).to eq 'email'
      end

      it 'has validations' do
        fill_in 'contact_type_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? contact_type.name
      count? 'Contact Types list(1)'

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::ContactType, :count).by(-1)

      count? 'Contact Types list(1)'
      has_content? contact_type.name
    end
  end

end
