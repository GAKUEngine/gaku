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

  let(:grading_method_set) { create(:grading_method_set, :with_grading_methods) }

  context 'new', js: true do
    before do
      syllabus
      visit gaku.courses_path
      click new_link
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
    end

    it { has_validations? }
  end

  context 'new with primary grading method set', js: true do
    before do
      grading_method_set
      syllabus
      visit gaku.courses_path
      click new_link
    end

    it 'create and show' do
      expect do
        fill_in 'course_code', with: 'SUMMER2012'
        select "#{syllabus.name}", from: 'course_syllabus_id'
        click submit
        flash_created?
        within('#courses-without-semester-index') do
          page.should have_content(syllabus.name)
        end
      end.to change(Gaku::Course, :count).by(1)

      has_content? 'SUMMER2012'

      click edit_link
      click '#course-grading-method-connectors-tab-link'
      within('#course-grading-method-connectors') do
        has_content? grading_method_set.grading_methods.first
        has_content? grading_method_set.grading_methods.second
      end

    end
  end

  context 'existing course' do
    before do
      course_with_semesters
      syllabus
      syllabus2
      visit gaku.courses_path
      within(count_div) { page.should have_content('Courses list(1)') }
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

      xit 'has validations', js: true do
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
        within("#semester-#{semester.id}-courses-index") do
          click delete_link
        end

        accept_alert
        flash_destroyed?
      end.to change(Gaku::Course, :count).by(-1)

      %W( #{semester.id} #{semester2.id} ).each do |id|
        within("#semester-#{id}-courses-index") do
          page.should_not have_content course_with_semesters.code
        end
      end

      within(count_div) { page.should_not have_content('Courses list(1)') }
    end

  end
end
