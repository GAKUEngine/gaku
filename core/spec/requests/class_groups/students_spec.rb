require 'spec_helper'

describe 'ClassGroup Students' do
  
  stub_authorization!

  let(:class_group) { create(:class_group, :grade => '1', :name => "Biology", :homeroom => 'A1') }
  let(:student1) { create(:student, :name => 'Susumu', :surname => 'Yokota') }

  before :all do
    set_resource "class-group-student" 
  end

  before do
    class_group
  end

  context "#new" do
    before do
      student1
      visit gaku.class_groups_path
      click show_link
      click_link 'class-group-enrollments-tab-link'
      Gaku::ClassGroupEnrollment.count.should eq 0
      click new_link
      wait_until_visible('#student-modal')
    end

    it 'adds and shows a student', :js => true do
      expect do
        find(:css, "input#student-#{student1.id}").set(true)
        wait_until_visible('#students-checked-div')
        within('#students-checked-div') do 
          page.should have_content('Chosen students(1)')
          click_link('Show')
          wait_until_visible('#chosen-table')
          page.should have_content("#{student1.name}")
          click_button 'Enroll to class'
        end
        wait_until_invisible('#student-modal')

        within(table){ page.should have_content("#{student1.name}") }
      end.to change(Gaku::ClassGroupEnrollment,:count).by 1
      
      within('.class-group-enrollments-count'){ page.should have_content("1") }
      within('#class-group-enrollments-tab-link'){ page.should have_content("1") }
    end

    it 'cancels adding', :js => true do
      expect do
        find(:css, "input#student-#{student1.id}").set(true)
        wait_until_visible('#students-checked-div')
        within('#students-checked-div') do 
          page.should have_content('Chosen students(1)')
          click_link('Show')
          wait_until { find('#chosen-table').visible? }
          page.should have_content("#{student1.name}")
        end
        click cancel_link
        wait_until_invisible('#student-modal')
      end.to change(Gaku::ClassGroupEnrollment, :count).by 0
      
      within(table) { page.should_not have_content("#{student1.name}") }
      within('.class-group-enrollments-count') { page.should_not have_content("1") }
      within('#class-group-enrollments-tab-link') { page.should_not have_content("1") }
    end
  end

  context "#search " do
    it 'searches students', :js => true do
      visit gaku.class_groups_path
      click show_link
      click_link 'class-group-enrollments-tab-link'

      student2 = create(:student, :name => 'Kenji', :surname => 'Kita')
      student3 = create(:student, :name => 'Chikuhei', :surname => 'Nakajima')

      click new_link
      wait_until_visible('#student-modal')
      fill_in 'q[name_cont]', :with => 'Sus'
     
      wait_until { size_of(table_rows) == 1 }
      
    end
  end

  context "when student is added" do
    before do
      class_group.students << student1
      visit gaku.class_group_path(class_group)
      within('.class-group-enrollments-count'){ page.should have_content("1") }
      within('#class-group-enrollments-tab-link'){ page.should have_content("1") }
      Gaku::ClassGroupEnrollment.count.should eq 1
    end

    it 'enrolls student only once', :js => true do
      click new_link
      wait_until { page.find('#student-modal').visible? }
      within('tr#student-' + student1.id.to_s) do
        page.should have_selector("img.enrolled")
      end
    end

    it 'deletes', :js => true do
      click_link 'class-group-enrollments-tab-link'
      
      ensure_delete_is_working
      
      within('.class-group-enrollments-count') { page.should_not have_content("1") }
      within('#class-group-enrollments-tab-link') { page.should_not have_content("1") }
    end
  end

end