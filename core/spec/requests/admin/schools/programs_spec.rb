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
      visit gaku.admin_school_path(school)
      click new_link
      wait_until_visible submit
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
        wait_until_invisible form
      end.to change(Gaku::Program, :count).by(1)

      Gaku::Program.last.tap do |p|
        p.syllabuses.count.should eq(1)
        p.levels.count.should eq(1)
        p.specialties.count.should eq(1)
      end

      page.should have_content 'Rails Ninja'
      within(count_div) { page.should have_content 'Programs list(1)' }
      flash_created?

      %w(level syllabus specialty).each do |resource|
        click ".program-#{resource.pluralize}-list"
        within("#show-program-#{resource.pluralize}-modal") do
          page.should have_content(send(resource).name)
          click close
        end
      end

    end

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', js: true do
    before do
      program
      visit gaku.admin_school_path(school)
    end

    context 'edit' do

      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do

        fill_in 'program_name', with: 'Rails Samurai'
        fill_in 'program_description', with: 'Rails Ninja Camp'

        select  specialty.name, from: 'program-specialty-select'
        select  level.name, from: 'program-level-select'
        select  syllabus.name, from: 'program-syllabus-select'

        click submit
        wait_until_invisible form

        within(table) { page.should have_content 'Rails Samurai' }
        flash_updated?

        %w(level syllabus specialty).each do |resource|
          click ".program-#{resource.pluralize}-list"
          within("#show-program-#{resource.pluralize}-modal") do
            page.should have_content(send(resource.to_s).name)
            click close
          end
        end

      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', js: true do
      page.should have_content program.name
      within(count_div) { page.should have_content 'Programs list(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Program, :count).by -1

      within(count_div) { page.should_not have_content 'Programs list(1)' }
      page.should_not have_content program.name
      flash_destroyed?
    end
  end
end