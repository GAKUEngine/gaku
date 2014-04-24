require 'spec_helper'

describe 'Student Simple Grades' do

  before(:all) { set_resource 'student-simple-grade' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:simple_grade_type) { create(:simple_grade_type) }
  let(:simple_grade) { create(:simple_grade,
                                student: student,
                                simple_grade_type:simple_grade_type) }

  context 'new', js: true do
    before do
      simple_grade_type
      visit gaku.edit_student_path(student)
      click '#student-simple-grades-menu a'
      click new_link
    end

    it 'creates' do
      expect do
        select simple_grade_type.name, from: 'simple_grade_simple_grade_type_id'
        fill_in 'simple_grade_score', with: 123
        fill_in 'simple_grade_award_date', with: Date.today
        page.find('body').click

        click submit
        within(table) { has_content? 'Ruby Science' }
      end.to change(Gaku::SimpleGrade, :count).by(1)

      count? 'Simple Grades list(1)'
      within('.simple-grades-count') { expect(page.has_content?('1')).to eq true }
      within('#student-simple-grades-index') do
        expect(page).to have_content Date.today
        expect(page).to have_content simple_grade_type.grading_method
        expect(page).to have_content simple_grade_type.school
      end
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      simple_grade
      visit gaku.edit_student_path(student)
      click '#student-simple-grades-menu a'
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        fill_in 'simple_grade_score', with: 33.3
        click submit

        flash_updated?

        within(table) do
          has_content? 33.3
          has_no_content? simple_grade.score
        end
      end

      it 'cancels editting' do
        click '.back-modal-link'
        within(table) { has_content? simple_grade.score }
      end

    end

    it 'deletes' do
      has_content? simple_grade.score
      count? 'Simple Grades list(1)'
      expect do
        ensure_delete_is_working
        within(table) { has_content? simple_grade.score }
      end.to change(Gaku::SimpleGrade, :count).by(-1)

      within(table) { has_no_content? simple_grade.score }
      within('.simple-grades-count') { expect(page.has_content?('0')).to eq true }
      count? 'Simple Grades list'
    end
  end

end
