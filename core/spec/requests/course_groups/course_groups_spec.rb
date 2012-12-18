require 'spec_helper'

describe 'CourseGroups' do

  stub_authorization!

  let(:course_group) { create(:course_group, :name => '2013Courses') }

  before :all do
    set_resource("course-group")
  end

  context '#new', :js => true do
    before do
      visit gaku.course_groups_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'course_group_name', :with => 'MathCourses2012'
        click submit
        wait_until_invisible form
      end.to change(Gaku::CourseGroup, :count).by 1

      within(count_div) { page.should have_content('Course Groups List(1)') }
      within (table) { page.should have_content 'MathCourses2012' }
      flash_created?
    end

    it {has_validations?}

    it 'cancels adding', :cancel => true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      course_group
      visit gaku.course_groups_path
    end

    context '#edit', :js => true do
      before do
        click edit_link
        wait_until_visible submit
      end

      it 'edits from index' do
        fill_in 'course_group_name', :with => '2012 Courses'
        click submit

        within (table) do
          page.should have_content '2012 Courses'
          page.should_not have_content '2013Courses'
        end

        Gaku::CourseGroup.last.name.should eq '2012 Courses'
        flash_updated?
      end

      it 'cancels editting', :cancel => true do
        ensure_cancel_modal_is_working
      end

      it 'edits from show' do
        visit gaku.course_group_path(course_group)
        click edit_link
        wait_until_visible submit

        fill_in 'course_group_name', :with => '2012 Courses'
        click submit

        within ('.table') do
          page.should have_content '2012 Courses'
          page.should_not have_content '2013Courses'
        end
        Gaku::CourseGroup.last.name.should eq '2012 Courses'
        flash_updated?
      end
    end

    it 'deletes', :js => true do
      visit gaku.course_group_path(course_group)

      page.should have_content course_group.name

      click '#delete-course-group-link'
      within(".delete-modal") { click_on "Delete" }
      accept_alert

      page.should_not have_content 'Course Groups List(1)'
      page.should_not have_content course_group.name
      flash_destroyed?
    end

    context "when select back btn" do
      it 'returns to index view' do
        visit gaku.course_group_path(course_group)
        click_on('Back')
        page.should have_content ('Course Groups List')
      end
    end

    context "when select show btn" do
      it 'redirects to show view' do
        within(table) { click show_link }
        page.should have_content ('Course Group')
        page.should have_content ('Courses list')
      end
    end


  end
end
