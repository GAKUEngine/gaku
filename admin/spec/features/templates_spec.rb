require 'spec_helper'

describe 'Admin Templates' do

  before { as :admin }

  let(:template) { create(:template) }

  before :all do
    Capybara.javascript_driver = :selenium
    set_resource 'admin-template'
  end

  context 'new', js: true do
    before do
      visit gaku.admin_templates_path
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'template_name', with: 'New Template'
        fill_in 'template_context', with: 'new_context'

        absolute_path = Rails.root + '../support/sample_roster.ods'
        attach_file 'template_file', absolute_path

        click submit
        sleep 1
        flash_created?
      end.to change(Gaku::Template, :count).by 1

      expect(page).to have_content 'New Template'
      within(count_div) { expect(page).to have_content 'Templates list(1)' }

      expect(current_path).to eq gaku.admin_templates_path
    end

    it 'has file validations' do
      expect do
        fill_in 'template_name', with: 'New Template'
        fill_in 'template_context', with: 'new_context'

        absolute_path = Rails.root + '../support/120x120.jpg'
        attach_file 'template_file', absolute_path

        click submit
        page.has_content? 'Only text, excel or openoffice documents are supported'
      end.not_to change(Gaku::Template, :count)
    end

    it { has_validations? }

  end

  context 'existing' do
    before do
      template
      visit gaku.admin_templates_path
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        fill_in 'template_name', with: 'Edited name'
        click submit

        flash_updated?

        expect(page).to have_content 'Edited name'
        expect(page).to_not have_content 'mobile'

        expect(current_path).to eq gaku.admin_templates_path
      end


      it 'has file validations' do
        fill_in 'template_name', with: 'New Template'
        fill_in 'template_context', with: 'new_context'

        absolute_path = Rails.root + '../support/120x120.jpg'
        attach_file 'template_file', absolute_path

        click submit
        page.has_content? 'Only text, excel or openoffice documents are supported'
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
        flash_destroyed?
      end.to change(Gaku::Template, :count).by(-1)

      within(count_div) do
        expect(page).to_not have_content 'Templates list(1)'
      end
      expect(page).to_not have_content template.name

    end
  end

end
