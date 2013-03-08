require 'spec_helper'

describe 'Simple Grade' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:school) { create(:school) }
  let(:simple_grade) { create(:simple_grade, :school => school, :student => student) }
  let!(:el) { '#index-student-simple-grades-link' }

  before :all do
    set_resource 'student-simple-grade'
  end

  context '#new', :js => true do
    before do
      school
      visit gaku.edit_student_path(student)
      click el
      click new_link
    end

    it 'create and show' do
      expect do
        fill_in 'simple_grade_name', :with => 'Ruby Science'
        fill_in 'simple_grade_grade', :with => 'A+'
        select school.name, :from => 'simple_grade_school_id'

        click submit
        wait_until_invisible form
      end.to change(Gaku::SimpleGrade, :count).by(1)

      within(el) { page.should have_content('Ruby Science') }
      within(count_div) { page.should have_content 'Simple Grades list(1)'}
      flash_created?
    end

  end

  context 'existing', :js => true do
    before do
      simple_grade
      visit gaku.edit_student_path(student)
      click el
    end

    context '#edit' do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        fill_in 'simple_grade_name', :with => 'Rails Science'
        click submit

        wait_until_invisible form
        page.should have_content('Rails Science')
        flash_updated?
      end

      it 'cancels editting' do
        click '.back-link'
        within(el) { page.should have_content(simple_grade.name) }
      end

    end

    it 'delete' do
      page.should have_content(simple_grade.name)
      within(count_div) { page.should have_content 'Simple Grades list(1)' }
      expect do
        ensure_delete_is_working
      end.to change(Gaku::SimpleGrade, :count).by(-1)

      within(count_div) { page.should have_content 'Simple Grades list' }
      within(el) { page.should_not have_content(simple_grade.name) }
      flash_destroyed?
    end
  end

end
