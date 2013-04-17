require 'spec_helper'

describe 'Admin Program' do

  as_admin

  let(:school) { create(:school)}
  let(:program) { create(:program, :school => school) }

  let(:level) { create(:level) }
  let(:syllabus) { create(:syllabus) }
  let(:specialty) { create(:specialty) }

  let(:level2) { create(:level, :name => 'Ruby Ninja Level2') }
  let(:syllabus2) { create(:syllabus, :name => 'Ruby Ninja Championship') }
  let(:specialty2) { create(:specialty, :name => 'Ruby throw exception') }

  let(:program_level) { create(:program_level, :level => level, :program => program) }
  let(:program_syllabus) { create(:program_syllabus, :syllabus => syllabus, :program => program) }
  let(:program_specialty) { create(:program_specialty, :specialty => specialty, :program => program) }

  before :all do
    set_resource "admin-school-program"
  end

  context 'new', :js => true do
    before do
      school
      level
      specialty
      syllabus
      visit gaku.admin_school_path(school)
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'program_name', :with => 'Rails Ninja'
        fill_in 'program_description', :with => 'Rails Ninja Camp'

        click '.add-program-specialty'
        select  specialty.name, :from => 'program-specialty-select'

        click '.add-program-level'
        select  level.name, :from => 'program-level-select'

        click '.add-program-syllabus'
        select  syllabus.name, :from => 'program-syllabus-select'

        click submit
        wait_until_invisible form
      end.to change(Gaku::Program, :count).by(1)

      Gaku::ProgramLevel.count.should eq(1)
      Gaku::ProgramSyllabus.count.should eq(1)
      Gaku::ProgramSpecialty.count.should eq(1)

      page.should have_content 'Rails Ninja'
      within(count_div) { page.should have_content 'Programs list(1)' }
      flash_created?

      ['level', 'syllabus', 'specialty'].each do |resource|
        click ".program-#{resource.pluralize}-list"
        within("#show-program-#{resource.pluralize}-modal") do
          page.should have_content(send(resource).name)
          click close
        end
      end

    end

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do
    before do
      school
      program
      level;syllabus; specialty
      level2; syllabus2; specialty2
      program_level; program_syllabus; program_specialty
      visit gaku.admin_school_path(school)
    end

    context 'edit' do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do

        fill_in 'program_name', :with => 'Rails Samurai'
        fill_in 'program_description', :with => 'Rails Ninja Camp'

        select  specialty2.name, :from => 'program-specialty-select'

        select  level2.name, :from => 'program-level-select'

        select  syllabus2.name, :from => 'program-syllabus-select'

        click submit
        wait_until_invisible form

        within(table) {page.should have_content 'Rails Samurai' }
        flash_updated?

        ['level', 'syllabus', 'specialty'].each do |resource|
          click ".program-#{resource.pluralize}-list"
          within("#show-program-#{resource.pluralize}-modal") do
            page.should have_content(send(resource + 2.to_s).name)
            click close
          end
        end

      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end
    end

    context 'delete' do
      before do
        school
        program
        visit gaku.admin_school_path(school)
      end

    end

    it 'deletes', :js => true do
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