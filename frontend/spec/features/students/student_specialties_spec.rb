require 'spec_helper'

describe 'Student Specialties' do

  before(:all) { set_resource 'student-specialty' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:specialty) { create(:specialty) }
  let(:student_specialty) { create(:student_specialty, student: student, specialty: specialty ) }
  let(:specialty2) { create(:specialty, name: 'Math Specialty') }

  context 'new', js: true do

    before do
      specialty
      visit gaku.edit_student_path(student)
      click '#student-specialties-menu a'
      click new_link
    end

    it 'create and show' do
      expect do
        expect do
          select specialty.name , from: 'student_specialty_specialty_id'
          click submit
          within(table) { has_content? specialty.name }
        end.to change(Gaku::StudentSpecialty, :count).by(1)
      end.to change(student.specialties, :count).by(1)

      count? 'Specialties list(1)'
      within('.specialties-count') { expect(page.has_content?('1')).to eq true }
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      specialty
      specialty2
      student_specialty
      visit gaku.edit_student_path(student)
      click '#student-specialties-menu a'
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        select specialty2.name , from: 'student_specialty_specialty_id'
        click submit
        flash_updated?

        within(table) do
          expect(page.has_content? specialty2.name).to eq true
          expect(page.has_no_content? specialty.name).to eq true
        end
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
        within(table) { has_no_content? specialty.name }
      end.to change(Gaku::StudentSpecialty, :count).by(-1)

      count? 'Specialties list'
      within('.specialties-count') { expect(page.has_content?('0')).to eq true }
    end

  end
end
