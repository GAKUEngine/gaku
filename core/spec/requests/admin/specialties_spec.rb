require 'spec_helper'

describe 'Admin Specialties' do

  before { as :admin }
  before(:all) { set_resource 'admin-specialty' }

  let(:specialty) { create(:specialty, name: 'Clojure dev') }

  context 'new', js: true do
    before do
      visit gaku.admin_specialties_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'specialty_name', with: 'home phone'
        click submit
        flash_created?
      end.to change(Gaku::Specialty, :count).by(1)

      has_content? 'home phone'
      count? 'Specialties list(1)'
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      specialty
      visit gaku.admin_specialties_path
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'specialty_name', with: 'Ruby dev'
        click submit

        flash_updated?
        has_content? 'Ruby dev'
        has_no_content? 'Clojure dev'
        expect(specialty.reload.name).to eq 'Ruby dev'
      end

      it 'has validations' do
        fill_in 'specialty_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      has_content? specialty.name
      count? 'Specialties list(1)'

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Specialty, :count).by -1

      flash_destroyed?
      count? 'Specialties list(1)'
      has_no_content? specialty.name
    end

  end
end
