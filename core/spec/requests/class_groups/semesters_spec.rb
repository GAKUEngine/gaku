require 'spec_helper'

describe 'ClassGroup Semesters' do

  stub_authorization!
  
  let!(:class_group) { create(:class_group, :grade => '1', :name => "Not so awesome class group", :homeroom => 'A1') }
  let(:semester) { create(:semester, :starting => "2012-10-21", :ending => "2012-11-21") }
  let(:semester2) { create(:semester, :starting => "2013-01-21", :ending => "2013-06-21") }

  before :all do
    set_resource "class-group-semester"
  end
  
  before do
    visit gaku.class_group_path(class_group)
    click tab_link
  end

  context 'new', :js => true do
    before do 
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do  
      expect do
        select '2012',      :from => 'semester_starting_1i'
        select 'September', :from => 'semester_starting_2i'
        select '28',        :from => 'semester_starting_3i'

        select '2012',      :from => 'semester_ending_1i'
        select 'December',  :from => 'semester_ending_2i'
        select '20',        :from => 'semester_ending_3i'
        click submit
        wait_until_invisible form
      end.to change(class_group.semesters,:count).by 1
      
      within(table) { page.should have_content '09/28/2012 - 12/20/2012' }
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link) { page.should have_content 'Semesters(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end

    it 'errors if ending date is <= starting date' do
      select '2012',      :from => 'semester_starting_1i'
      select 'October', :from => 'semester_starting_2i'
      select '15',        :from => 'semester_starting_3i'

      select '2012',      :from => 'semester_ending_1i'
      select 'October',  :from => 'semester_ending_2i'
      select '15',        :from => 'semester_ending_3i'
      click submit

      within('#semesters') { page.should have_content 'Ending should be after Starting' }
    end

  end

  context 'existing', :js => true do
    before do
      class_group.semesters << semester
      visit gaku.class_group_path(class_group)
      click tab_link
      within(count_div) { page.should have_content '1' }
      within(tab_link) { page.should have_content 'Semesters(1)' }
    end

    it "errors if already exists" do 
      click new_link
      wait_until_visible submit

      select '2012',      :from => 'semester_starting_1i'
      select 'October', :from => 'semester_starting_2i'
      select '21',        :from => 'semester_starting_3i'

      select '2012',      :from => 'semester_ending_1i'
      select 'November',  :from => 'semester_ending_2i'
      select '21',        :from => 'semester_ending_3i'
      click submit
      within('#semesters') { page.should have_content 'Class group have this semester added' }
    end

    context 'edit', :js => true do
      before do 
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it 'edits' do
        select '2012',      :from => 'semester_starting_1i'
        select 'September', :from => 'semester_starting_2i'
        select '15',        :from => 'semester_starting_3i'

        select '2013',      :from => 'semester_ending_1i'
        select 'February',  :from => 'semester_ending_2i'
        select '15',        :from => 'semester_ending_3i'
        click submit
        
        wait_until_invisible modal
        within(table) { page.should have_content '09/15/2012 - 02/15/2013' }
        within(table) { page.should_not have_content '10/21/2012 - 11/21/2012' }
        flash_updated?
      end

      it 'cancels editing' do
        ensure_cancel_modal_is_working
      end

      context '2 existing' do
        before do
          class_group.semesters << semester2
          visit gaku.class_group_path(class_group)
          click tab_link 
          within(count_div) { page.should have_content '2' }
          within(tab_link) { page.should have_content 'Semesters(2)' }

          within("table tr#semester-#{semester2.id}") { click edit_link }
          wait_until_visible modal
        end

        it 'errors if already exists' do
          select '2012',      :from => 'semester_starting_1i'
          select 'October', :from => 'semester_starting_2i'
          select '21',        :from => 'semester_starting_3i'

          select '2012',      :from => 'semester_ending_1i'
          select 'November',  :from => 'semester_ending_2i'
          select '21',        :from => 'semester_ending_3i'
          click submit
          within(modal) { page.should have_content 'Class group have this semester added' }
        end

        it 'errors if ending is <= starting' do
          select '2012',      :from => 'semester_starting_1i'
          select 'October', :from => 'semester_starting_2i'
          select '15',        :from => 'semester_starting_3i'

          select '2012',      :from => 'semester_ending_1i'
          select 'October',  :from => 'semester_ending_2i'
          select '15',        :from => 'semester_ending_3i'
          click submit
          
          within(modal) { page.should have_content 'Ending should be after Starting' }
        end
      end
    end

    it 'deletes', :js => true do
      page.should have_content '10/21/2012 - 11/21/2012'
      within(count_div) { page.should have_content 'Semesters list(1)' }
      within(tab_link) { page.should have_content 'Semesters(1)' }

      expect do
        ensure_delete_is_working
      end.to change(class_group.semesters,:count).by -1
      
      within(count_div) { page.should_not have_content 'Semesters list(1)' }
      within(tab_link) { page.should_not have_content 'Semesters(1)' }
      page.should_not have_content '10/21/2012 - 11/21/2012'
      flash_destroyed?
    end
  end

end