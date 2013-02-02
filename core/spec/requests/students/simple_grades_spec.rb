require 'spec_helper'

describe 'Simple Grade' do

  stub_authorization!

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:school) { create(:school) }
  let(:simple_grade) { create(:simple_grade, :school => school, :student => student) }

  before :all do
    set_resource 'student-simple-grade'
  end

  context '#new', :js => true do
    before do
      school
      visit gaku.student_path(student)
      click '#index-student-simple-grades-link'
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

      page.should have_content('Ruby Science')
      within(count_div) { page.should have_content 'Simple Grades list(1)'}
      flash_created?
    end

    it 'cancel creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing', :js => true do
    before do
      simple_grade
      visit gaku.student_path(student)
      click '#index-student-simple-grades-link'
    end

    context '#edit' do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        fill_in 'simple_grade_name', :with => 'Rails Science'
        click submit

        page.should have_content('Rails Science')
        flash_updated?
      end

      it 'cancels editting' do
        click '.back-link'
        within(table) { page.should have_content(simple_grade.name) }
      end

    end

    it 'delete' do
      page.should have_content(simple_grade.name)
      within(count_div) { page.should have_content 'Simple Grades list(1)' }
      expect do
        ensure_delete_is_working
      end.to change(Gaku::SimpleGrade, :count).by(-1)

      within(count_div) { page.should have_content 'Simple Grades list' }
      page.should_not have_content(simple_grade.name)
      flash_destroyed?
    end
  end

end