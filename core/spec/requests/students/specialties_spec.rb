require 'spec_helper'

describe 'Student Specialties' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:specialty) {create(:specialty) }
  let(:student_specialty) {create(:student_specialty, :student => student, :specialty => specialty )}
  let(:specialty2) { create(:specialty, :name => 'Math Specialty') }
  let!(:el) { '#specialties' }

  before :all do
    set_resource 'student-specialty'
  end

  context '#new', :js => true do

    before do
      specialty
      visit gaku.edit_student_path(student)
      within(el) { page.should have_content("Empty") }
      click el
      click new_link
      wait_until_visible cancel_link
    end

    it 'create and show' do
      expect do
        select specialty.name , :from => 'student_specialty_specialty_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::StudentSpecialty, :count).by(1)

      within(el) { page.should have_content(specialty.name) }
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
      visit gaku.edit_student_path(student)
      click el
    end

    context '#edit' do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        select specialty2.name , :from => 'student_specialty_specialty_id'
        click submit

        within(el) do
          page.should have_content(specialty2.name)
          page.should_not have_content(specialty.name)
        end
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
      within(el) { page.should_not have_content(specialty.name) }

      flash_destroyed?
    end

  end
end
