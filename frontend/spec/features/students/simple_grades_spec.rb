require 'spec_helper'

describe 'Student Simple Grades' do

  before(:all) { set_resource 'student-simple-grade' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:school) { create(:school) }
  let(:simple_grade) { create(:simple_grade, name: 'Test', school: school, student: student) }
  let!(:el) { '#simple-grades' }

  context 'new', js: true do
    before do
      school
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
      click new_link
    end

    it 'creates' do
      expect do
        fill_in 'simple_grade_name', with: 'Ruby Science'
        fill_in 'simple_grade_grade', with: 'A+'
        select school.name, from: 'simple_grade_school_id'

        click submit
        within(el) { has_content? 'Ruby Science' }
      end.to change(Gaku::SimpleGrade, :count).by(1)

      count? 'Simple Grades list(1)'
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      simple_grade
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        fill_in 'simple_grade_name', with: 'Rails Science'
        click submit

        flash_updated?

        within(el) do
          has_content? 'Rails Science'
          has_no_content? 'Test'
        end
      end

      it 'cancels editting' do
        click '.back-modal-link'
        within(el) { has_content? simple_grade.name }
      end

    end

    it 'deletes' do
      has_content? simple_grade.name
      count? 'Simple Grades list(1)'
      expect do
        ensure_delete_is_working
        within(el) { has_content? simple_grade.name }
      end.to change(Gaku::SimpleGrade, :count).by(-1)

      count? 'Simple Grades list'
    end
  end

end
