require 'spec_helper'

describe 'ClassGroups' do

  before { as :admin }

  let(:class_group) do
    create(:class_group, grade: '1',
                         name: 'Not so awesome class group',
                         homeroom: 'A1')
  end

  let(:class_group_with_semesters) { create(:class_group, :with_semesters) }

  before :all do
    set_resource('class-group')
  end

  context 'new', js: true do
    before do
      visit gaku.class_groups_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows', js: true do
      expect do
        fill_in 'class_group_grade',    with: '7'
        fill_in 'class_group_name',     with: 'Awesome class group'
        fill_in 'class_group_homeroom', with: 'room#7'
        click submit
        wait_until_invisible form
      end.to change(Gaku::ClassGroup, :count).by 1

      within('#class-groups-without-semester-index') do
        page.should have_content '7'
        page.should have_content 'Awesome class group'
        page.should have_content 'room#7'
      end

      within(count_div) { page.should have_content 'Class Groups list(1)' }
      flash_created?
    end

    it { has_validations? }

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      class_group_with_semesters
      visit gaku.class_groups_path
    end

    context 'edit', js: true do
      before do
        click edit_link
        wait_until_visible modal
      end

      it 'edits' do
        semester, semester2 = class_group_with_semesters.semesters
        fill_in 'class_group_grade',    with: '2'
        fill_in 'class_group_name',     with: 'Really awesome class group'
        fill_in 'class_group_homeroom', with: 'B2'

        click submit

        %W( #{semester.id} #{semester2.id} ).each do |id|
          within("#semester-#{id}-class-groups-index") do
            page.should have_content 'Really awesome class group'
            page.should have_content '2'
            page.should have_content 'B2'
          end
        end

        page.should_not have_content 'Not so awesome class group'
        page.should_not have_content 'A1'

        edited_class_group = Gaku::ClassGroup.last
        edited_class_group.name.should eq 'Really awesome class group'
        edited_class_group.grade.should eq 2
        edited_class_group.homeroom.should eq 'B2'
        flash_updated?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

      it 'edits from show view' do
        visit gaku.class_group_path(class_group_with_semesters)
        click edit_link
        wait_until_visible modal

        fill_in 'class_group_grade',    with: '2'
        fill_in 'class_group_name',     with: 'Really awesome class group'
        fill_in 'class_group_homeroom', with: 'B2'

        click submit

        page.should have_content 'Really awesome class group'
        page.should have_content '2'
        page.should have_content 'B2'

        page.should_not have_content 'Not so awesome class group'
        page.should_not have_content 'A1'

        edited_class_group = Gaku::ClassGroup.last
        edited_class_group.name.should eq 'Really awesome class group'
        edited_class_group.grade.should eq 2
        edited_class_group.homeroom.should eq 'B2'
        flash_updated?
      end

      it 'has validations' do
        fill_in 'class_group_name', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      semester, semester2 = class_group_with_semesters.semesters

      %W( #{semester.id} #{semester2.id} ).each do |id|
        within("#semester-#{id}-class-groups-index") do
          page.should have_content class_group_with_semesters.name
        end
      end

      within(count_div) { page.should have_content 'Class Groups list(1)' }

      expect do
        rows = "#semester-#{semester.id}-class-groups-index tr"
        tr_count = size_of rows

        within("#semester-#{semester.id}-class-groups-index") do
          click delete_link
        end

        accept_alert
        wait_until { size_of(rows) == tr_count - 1 }

      end.to change(Gaku::ClassGroup, :count).by(-1)

      %W( #{semester.id} #{semester2.id} ).each do |id|
        within("#semester-#{id}-class-groups-index") do
          page.should_not have_content class_group_with_semesters.name
        end
      end

      within(count_div) { page.should_not have_content 'Class Groups list(1)' }
      flash_destroyed?
    end

    it 'returns to class groups index when back is selected' do
      visit gaku.class_group_path(class_group_with_semesters)
      click_link('back-class-group-link')
      page.should have_content('Class Groups list')
    end

    it 'redirects to show view when show btn selected' do
      within(table) { click show_link }
      page.should have_content('Show')
    end

  end
end
