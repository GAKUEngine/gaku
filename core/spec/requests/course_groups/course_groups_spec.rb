require 'spec_helper'

describe 'CourseGroups' do

  before { as :admin }

  let(:course_group) { create(:course_group, name: '2013Courses') }

  before :all do
    set_resource('course-group')
  end

  context '#new', js: true do
    before do
      visit gaku.course_groups_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'course_group_name', with: 'MathCourses2012'
        click submit
        flash_created?
      end.to change(Gaku::CourseGroup, :count).by 1

      within(count_div) { page.should have_content('Course Groups List(1)') }
      within (table) { page.should have_content 'MathCourses2012' }

    end

    it {has_validations?}
  end

  context 'existing' do
    before do
      course_group
      visit gaku.course_groups_path
    end

    context '#edit', js: true do
      before do
        click js_edit_link
        wait_until_visible submit
      end

      it 'edits from index' do
        fill_in 'course_group_name', with: '2012 Courses'
        click submit

        within (table) do
          page.should have_content '2012 Courses'
          page.should_not have_content '2013Courses'
        end

        Gaku::CourseGroup.last.name.should eq '2012 Courses'
        flash_updated?
      end

      it 'has validations' do
        fill_in 'course_group_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      visit gaku.edit_course_group_path(course_group)

      click modal_delete_link
      within('#delete-modal') { click_on 'Delete' }
      accept_alert

      page.should_not have_content 'Course Groups List(1)'
      page.should_not have_content course_group.name
      flash_destroyed?
    end


  end
end
