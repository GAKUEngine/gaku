require 'spec_helper'

describe 'Student Specialties' do

  before(:all) { set_resource 'student-specialty' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:specialty) {create(:specialty) }
  let(:student_specialty) {create(:student_specialty, student: student, specialty: specialty )}
  let(:specialty2) { create(:specialty, name: 'Math Specialty') }
  let!(:el) { '#specialties' }

  context 'new', js: true do

    before do
      specialty
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      within(el) { page.should have_content('Empty') }
      click el
      click new_link
    end

    it 'create and show' do
      expect do
        expect do
          select specialty.name , from: 'student_specialty_specialty_id'
          click submit
          flash_created?
        end.to change(Gaku::StudentSpecialty, :count).by(1)
      end.to change(student.specialties, :count).by(1)

      within(el) { has_content? specialty.name }
      count? 'Specialties list(1)'
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      specialty
      specialty2
      student_specialty
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        select specialty2.name , from: 'student_specialty_specialty_id'
        click submit

        within(el) do
          has_content? specialty2.name
          has_no_content? specialty.name
        end
        flash_updated?
      end

      it 'cancels editting' do
        click '.back-modal-link'
        within(table) { has_content? specialty.name }
      end
    end

    it 'delete' do
      has_content? specialty.name
      count? 'Specialties list(1)'
      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::StudentSpecialty, :count).by(-1)


      count? 'Specialties list'
      within(el) { has_no_content? specialty.name }
    end

  end
end
