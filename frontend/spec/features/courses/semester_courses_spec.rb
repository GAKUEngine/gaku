require 'spec_helper'

describe 'Course Semesters' do

  before { as :admin }

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
      visit gaku.edit_course_path(course)
      click tab_link
      click new_link
    end

    it 'creates and shows' do
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_course_semester_id'
        click submit
        flash_created?
      end.to change(Gaku::SemesterCourse, :count).by(1)

      within(table) { page.should have_content "#{semester.starting} / #{semester.ending}" }
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link) { page.should have_content 'Semesters(1)' }
    end

    it 'presence validations'  do
      has_validations?
    end


    xit 'uniqness scope validations'  do
      semester_course
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_course_semester_id'
        click submit
      end.to change(Gaku::SemesterCourse, :count).by(0)
      page.should have_content('Semester already added to Course')
    end

  end

  context 'existing' do
    before do
      course_with_semester
      course_semester
      semester
      visit gaku.edit_course_path(course_with_semester)
      click tab_link
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_course_semester_id'
        click submit

        flash_updated?
        within(table) do
          page.should have_content "#{semester.starting} / #{semester.ending}"
          page.should_not have_content "#{course_semester.starting} / #{course_semester.ending}"
        end
      end
    end

    it 'delete', js: true do
      within(table)     { page.should have_content "#{course_semester.starting} / #{course_semester.ending}" }
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link)  { page.should have_content 'Semesters(1)' }

      expect do
        ensure_delete_is_working
        flash_destroyed?
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
    end

  end
end