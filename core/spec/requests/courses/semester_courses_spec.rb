require 'spec_helper'

describe 'Course Semesters' do

  as_admin

  let(:course) { create(:course) }
  let(:course_with_semester) { create(:course, :with_semester) }
  let(:course_semester) { course_with_semester.semesters.first }
  let(:semester_course) { create(:semester_course, semester: semester, course: course) }
  let(:semester) do
    create(:semester,
           starting: Date.parse('2013-6-1'),
           ending:  Date.parse('2013-12-30'))
  end

  before :all do
    set_resource 'course-semester-course'
  end

  context 'new', js: true do
    before do
      course
      semester
      visit gaku.course_path(course)
      click tab_link
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_course_semester_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::SemesterCourse, :count).by(1)

      within(table) { page.should have_content "#{semester.starting} / #{semester.ending}" }
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link) { page.should have_content 'Semesters(1)' }
      flash_created?
    end

    it 'presence validations'  do
      has_validations?
    end


    it 'uniqness scope validations'  do
      semester_course
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_course_semester_id'
        click submit
      end.to change(Gaku::SemesterCourse, :count).by(0)
      page.should have_content('Semester already added to Course')
    end

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      course_with_semester
      course_semester
      semester
      visit gaku.course_path(course_with_semester)
      click tab_link
    end

    context 'edit', js: true do
      before do
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_course_semester_id'
        click submit

        wait_until_invisible modal
        within(table) do
          page.should have_content "#{semester.starting} / #{semester.ending}"
          page.should_not have_content "#{course_semester.starting} / #{course_semester.ending}"
        end
        flash_updated?
      end

      it 'cancels editing', cancel: true do
        ensure_cancel_modal_is_working
      end
    end

    it 'delete', js: true do
      within(table)     { page.should have_content "#{course_semester.starting} / #{course_semester.ending}" }
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link)  { page.should have_content 'Semesters(1)' }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::SemesterCourse, :count).by(-1)

      within(table)     { page.should_not have_content "#{course_semester.starting} / #{course_semester.ending}" }
      within(count_div) do
        page.should_not have_content 'Semesters list(1)'
        page.should have_content 'Semesters list'
      end

      within(tab_link) do
        page.should_not have_content 'Semesters(1)'
        page.should have_content 'Semesters'
      end

      flash_destroyed?
    end

  end
end