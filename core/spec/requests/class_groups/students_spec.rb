require 'spec_helper'

describe 'ClassGroup Students' do

  as_admin

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
        enroll_one_student_via_button('Enroll to class')
      end.to change(Gaku::ClassGroupEnrollment,:count).by 1
      
      page.should have_content "#{student1} : Successfully enrolled!"
      within('.class-group-enrollments-count'){ page.should have_content("1") }
      within('#class-group-enrollments-tab-link'){ page.should have_content("1") }
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
