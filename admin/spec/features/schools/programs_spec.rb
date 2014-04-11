require 'spec_helper'

describe 'Admin Program' do

  before { as :admin }

  let!(:school) { create(:school) }

  let!(:level) { create(:level, name: 'Ruby Ninja Level2') }
  let!(:syllabus) { create(:syllabus, name: 'Ruby Ninja Championship') }
  let!(:specialty) { create(:specialty, name: 'Ruby throw exception') }

  let(:program) { create(:program, :with_program_level, :with_program_syllabus, :with_program_specialty, school: school) }

  before :all do
    set_resource 'admin-school-program'
  end

  context 'new', js: true do
    before do
      visit gaku.edit_admin_school_path(school)
      click '#programs-menu a'
      click new_link
    end

    it 'creates and shows' do
      expect do
        fill_in 'program_name', with: 'Rails Ninja'
        fill_in 'program_description', with: 'Rails Ninja Camp'

        click '.add-program-specialty'
        select  specialty.name, from: 'program-specialty-select'

        click '.add-program-level'
        select  level.name, from: 'program-level-select'

        click '.add-program-syllabus'
        select  syllabus.name, from: 'program-syllabus-select'

        click submit
        flash_created?
      end.to change(Gaku::Program, :count).by(1)

      Gaku::Program.last.tap do |p|
        p.syllabuses.count.should eq(1)
        p.levels.count.should eq(1)
        p.specialties.count.should eq(1)
      end

      page.should have_content 'Rails Ninja'
      within(count_div) { page.should have_content 'Programs list(1)' }
      within('.programs-count') { expect(page.has_content?('1')).to eq true }

      %w(level syllabus specialty).each do |resource|
        click ".program-#{resource.pluralize}-list"
        within("#show-program-#{resource.pluralize}-modal") do
          page.should have_content(send(resource).name)
          click close
        end
      end

    end

  end

  context 'existing', js: true do
    before do
      program
      visit gaku.edit_admin_school_path(school)
      click '#programs-menu a'
    end

    context 'edit' do

      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do

        fill_in 'program_name', with: 'Rails Samurai'
        fill_in 'program_description', with: 'Rails Ninja Camp'

        select  specialty.name, from: 'program-specialty-select'
        select  level.name, from: 'program-level-select'
        select  syllabus.name, from: 'program-syllabus-select'

        click submit
        flash_updated?

        within(table) { page.should have_content 'Rails Samurai' }


        %w(level syllabus specialty).each do |resource|
          click ".program-#{resource.pluralize}-list"
          within("#show-program-#{resource.pluralize}-modal") do
            page.should have_content(send(resource.to_s).name)
            click close
          end
        end

      end

    end

    it 'deletes', js: true do
      within('#admin-school-programs-index') { expect(page.has_content?(program.name)).to eq true }
      within(count_div) { page.should have_content 'Programs list(1)' }

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::Program, :count).by -1

      within('#admin-school-programs-index') { expect(page.has_no_content?(program.name)).to eq true }
      within(count_div) { page.should_not have_content 'Programs list(1)' }
      within('.programs-count') { expect(page.has_no_content?('1')).to eq true }

    end
  end
end