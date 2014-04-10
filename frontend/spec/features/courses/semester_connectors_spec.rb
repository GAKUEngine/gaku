require 'spec_helper'

describe 'Course Semester Connectors' do

  before { as :admin }

  let(:course) { create(:course) }
  let(:school_year) { create(:school_year, starting: Date.parse('2013-1-1'), ending: Date.parse('2013-12-30')) }
  let(:semester) { create(:semester, school_year: school_year, starting: Date.parse('2013-1-1'), ending: Date.parse('2013-6-1')  )}
  let(:semester2) { create(:semester, school_year: school_year, starting: Date.parse('2013-6-1'), ending: Date.parse('2013-12-30')  )}
  let(:semester_connector_course) { create(:semester_connector_course, semester: semester, semesterable: course)}

  before :all do
    set_resource 'course-semester-connector'
  end

  before do
    course
  end

  context 'new', js: true do
    before do
      semester
      visit gaku.edit_course_path(course)
      click tab_link
      click new_link
    end

    it 'creates and shows' do
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_connector_semester_id'
        click submit
        flash_created?
      end.to change(Gaku::SemesterConnector, :count).by(1)

      within(table) { expect(page).to have_content "#{semester.starting} / #{semester.ending}" }
      within(tab_link) { expect(page).to have_content 'Semesters(1)' }
      within(count_div) { expect(page).to have_content 'Semesters list(1)' }

    end

    it 'presence validations'  do
      has_validations?
    end

    it 'uniqness scope validations'  do
      semester_connector_course
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_connector_semester_id'
        click submit
      end.to change(Gaku::SemesterConnector, :count).by(0)
      expect(page).to have_content('Semester already added')
    end

  end

  context 'existing' do
    before do
      semester
      semester2
      semester_connector_course
      visit gaku.edit_course_path(course)
      click tab_link
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        select "#{semester2.starting} / #{semester2.ending}", from: 'semester_connector_semester_id'
        click submit

        flash_updated?
        within(table) { expect(page).to have_content "#{semester2.starting} / #{semester2.ending}" }
        within(table) { expect(page).to_not have_content "#{semester.starting} / #{semester.ending}" }
      end

    end

    it 'delete', js: true do
      within(table)     { expect(page).to have_content "#{semester.starting} / #{semester.ending}" }
      within(tab_link)  { expect(page).to have_content 'Semesters(1)' }

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::SemesterConnector,:count).by -1

      within(table)     { expect(page).to_not have_content "#{semester.starting} / #{semester.ending}" }
      within(tab_link) { expect(page).to_not have_content 'Semesters(1)' }
      within(tab_link) { expect(page).to have_content 'Semesters' }
    end
  end
end
