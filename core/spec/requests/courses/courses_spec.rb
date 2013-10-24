require 'spec_helper'

describe 'Courses' do

  before(:all) { set_resource 'course' }
  before { as :admin }

  let(:syllabus) { create(:syllabus, name: 'biology2012', code: 'bio') }
  let(:syllabus2) do
    create(:syllabus, name: 'biology2013Syllabus', code: 'biology')
  end
  let(:course) { create(:course, syllabus: syllabus) }
  let(:course_with_semesters) do
    create(:course, :with_semesters, syllabus: syllabus)
  end

  context '#new', js: true do
    before do
      syllabus
      visit gaku.courses_path
      click new_link
      wait_until_visible submit
    end

    it 'creates new course' do
      expect do
        fill_in 'course_code', with: 'SUMMER2012'
        select "#{syllabus.name}", from: 'course_syllabus_id'
        click submit
        flash_created?
        within('#courses-without-semester-index') do
          page.should have_content(syllabus.name)
        end
      end.to change(Gaku::Course, :count).by(1)

      within(count_div) { page.should have_content('Courses list(1)') }
      wait_until_invisible '#new-course'
    end

    it { has_validations? }
  end

  context 'existing course' do
    before do
      course_with_semesters
      syllabus
      syllabus2
      visit gaku.courses_path
      within(count_div) { page.should have_content('Courses list(1)') }
    end

    context 'edit ' do
      context 'from index view' do
        before do
          click js_edit_link
        end

        it 'has validations', js: true do
          fill_in 'course_code', with: ''
          has_validations?
        end

        it 'edits a course', js: true  do
          semester, semester2 = course_with_semesters.semesters

          fill_in 'course_code', with: 'biology2013'
          select syllabus2.name, from: 'course_syllabus_id'

          click submit

          %W( #{semester.id} #{semester2.id} ).each do |id|
            within("#semester-#{id}-courses-index") do
              page.should have_content 'biology2013'
              page.should have_content syllabus2.name
              page.should_not have_content syllabus.name
            end
          end

          flash_updated?
        end
      end
    end

    context 'from edit view' do
      before do
        within("#semester-#{course_with_semesters.semesters.first.id}-courses-index") do
          click edit_link
        end
      end

      it 'edits', js: true do
        fill_in 'course_code', with: 'biology2013'
        page.select 'biology2013Syllabus', from: 'course_syllabus_id'
        click submit

        flash_updated?
        expect(find_field('course_code').value).to eq 'biology2013'
        course_with_semesters.reload
        expect(course_with_semesters.code).to eq 'biology2013'
      end

      it 'has validations', js: true do
        fill_in 'course_code', with: ''
        has_validations?
      end
    end

    xit 'deletes', js: true do
      semester, semester2 = course_with_semesters.semesters

      %W( #{semester.id} #{semester2.id} ).each do |id|
        within("#semester-#{id}-courses-index") do
          page.should have_content course_with_semesters.code
        end
      end

      within(count_div) { page.should have_content('Courses list(1)') }

      expect do
        rows = "#semester-#{semester.id}-courses-index tr"
        tr_count = size_of rows

        within("#semester-#{semester.id}-courses-index") do
          click delete_link
        end

        accept_alert
        wait_until { size_of(rows) == tr_count - 1 }

      end.to change(Gaku::Course, :count).by(-1)

      %W( #{semester.id} #{semester2.id} ).each do |id|
        within("#semester-#{id}-courses-index") do
          page.should_not have_content course_with_semesters.code
        end
      end

      within(count_div) { page.should_not have_content('Courses list(1)') }
      flash_destroyed?

    end
  end
end
