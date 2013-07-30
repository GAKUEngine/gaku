require 'spec_helper'

describe 'Admin Templates' do

  as_admin

  let(:template) { create(:template) }

  before :all do
    set_resource 'admin-template'
  end

  context 'new', js: true do
    before do
      visit gaku.admin_templates_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'template_name', with: 'New Template'
        fill_in 'template_context', with: 'new_context'

        absolute_path = Rails.root + '../support/sample_roster.ods'
        attach_file 'template_file', absolute_path

        click submit
        wait_until_invisible form
      end.to change(Gaku::Template, :count).by 1

      expect(page).to have_content 'New Template'
      within(count_div) { expect(page).to have_content 'Templates list(1)' }
      flash_created?

      expect(current_path).to eq gaku.admin_templates_path
    end

    it { has_validations? }

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      template
      visit gaku.admin_templates_path
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'template_name', with: 'Edited name'
        click submit

        wait_until_invisible modal

        expect(page).to have_content 'Edited name'
        expect(page).to_not have_content 'mobile'
        flash_updated?

        expect(current_path).to eq gaku.admin_templates_path
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

      it 'has validations' do
        fill_in 'template_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      expect(page).to have_content template.name
      within(count_div) { expect(page).to have_content 'Templates list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Template, :count).by(-1)

      within(count_div) do
        expect(page).to_not have_content 'Templates list(1)'
      end
      expect(page).to_not have_content template.name
      flash_destroyed?
    end
  end

end
