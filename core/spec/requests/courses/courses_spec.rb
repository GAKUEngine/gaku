require 'spec_helper'

describe 'Courses' do

  as_admin

  let(:syllabus) { create(:syllabus, :name => 'biology2012', :code => 'bio') }
  let(:syllabus2) { create(:syllabus, :name => 'biology2013Syllabus', :code => 'biology') }
  let(:course) { create(:course, :syllabus => syllabus) }

  before :all do
    set_resource "course"
  end

  context '#new', :js => true do
    before do
      syllabus
      visit gaku.courses_path
      click new_link
      wait_until_visible submit
    end

    it "creates new course" do
      expect do
        fill_in 'course_code', :with => 'SUMMER2012'
        select "#{syllabus.name}", :from => 'course_syllabus_id'
        click submit
        wait_until_invisible form
        within(table) { page.should have_content(syllabus.name) }
      end.to change(Gaku::Course, :count).by 1

      within(count_div) { page.should have_content('Courses list(1)') }
      wait_until_invisible '#new-course'
      flash_created?
    end

    it {has_validations?}

    it 'cancels creating', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context "existing course" do
    before do
      course
      syllabus2
      visit gaku.courses_path
      within(count_div) { page.should have_content('Courses list(1)') }
    end

    it "lists and shows existing courses" do
      within(table) do
        page.should have_content("biology")
        click show_link
      end

      page.should have_content('Course Code')
      page.should have_content('biology')
    end

    context "when select back btn" do
      it 'returns to index view', js:true do
        visit gaku.course_path(course)
        click_on('Back')
        page.current_path.should eq gaku.courses_path
      end
    end

    context ' #edit ' do
      before do
        within(table) { click edit_link }
        page.should have_content("Edit Course")
      end

      it 'has validations', :js => true do
        fill_in 'course_code', :with => ''
        has_validations?
      end

      it "edits a course", :js => true  do
        fill_in 'course_code', :with => 'biology2013'
        page.select "biology2013Syllabus", :from => 'course_syllabus_id'
        click submit

        page.should have_content "biology2013Syllabus"
        page.should have_content "biology2013"
        flash_updated?
      end
    end

    it "edits a course from show", :js => true do
      within(table) { click show_link }
      page.should have_content("Show")

      click edit_link
      wait_until_visible(modal)

      page.should have_content("Edit Course")
      fill_in 'course_code', :with => 'biology2013'
      page.select "biology2013Syllabus", :from => 'course_syllabus_id'
      click submit

      page.should have_content "biology2013Syllabus"
      page.should have_content "biology2013"

      flash_updated?
    end

    it "should delete a course", :js => true do
      tr_count = page.all(table_rows).size
      within(count_div) { page.should have_content('Courses list(1)') }
      within(table) { page.should have_content(course.code) }

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Course, :count).by -1

      within(count_div) { page.should_not have_content('Courses list(1)') }
      within(table) { page.should_not have_content(course.code) }
      flash_destroyed?
    end
  end
end
