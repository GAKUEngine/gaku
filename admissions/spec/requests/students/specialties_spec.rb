require 'spec_helper'

describe 'Admin Student Specialties' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:specialty) {create(:specialty) }
  let(:student_specialty) {create(:student_specialty, :student => student, :specialty => specialty )}
  let(:specialty2) { create(:specialty, :name => 'Math Specialty') }

  before :all do
    set_resource 'student-specialty'
  end

  context '#new', :js => true do

    before do
      specialty
      visit gaku.edit_admin_student_path(student)
      click '#index-student-specialties-link'
      click new_link
      sleep 1 # because it is failing some times
    end

    it 'create and show' do
      expect do
        select specialty.name , :from => 'student_specialty_specialty_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::StudentSpecialty, :count).by(1)

      page.should have_content(specialty.name)
      within(count_div) { page.should have_content "Specialties list(1)"}
      flash_created?
    end

    it 'cancel creating', :cancel => true do
      ensure_cancel_creating_is_working
    end

    it {has_validations?}
  end

  context 'existing', :js => true do
    before do
      specialty
      specialty2
      student_specialty
      visit gaku.edit_admin_student_path(student)
      click '#index-student-specialties-link'
    end

    context '#edit' do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        select specialty2.name , :from => 'student_specialty_specialty_id'
        click submit

        page.should have_content(specialty2.name)
        page.should_not have_content(specialty.name)
        flash_updated?
      end

      it 'cancels editting' do
        click '.back-link'
        within(table) { page.should have_content(specialty.name) }
      end
    end

    it 'delete' do
      page.should have_content(specialty.name)
      within(count_div) { page.should have_content 'Specialties list(1)' }
      expect do
        ensure_delete_is_working
      end.to change(Gaku::StudentSpecialty, :count).by(-1)

      within(count_div) { page.should have_content 'Specialties list' }
      page.should_not have_content(specialty.name)
      flash_destroyed?

    end
  end
end
