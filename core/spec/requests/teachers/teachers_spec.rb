require 'spec_helper'

describe 'Teachers' do

  as_admin

  let(:teacher) { create(:teacher, name: 'John', surname: 'Doe') }
  let(:teacher2) { create(:teacher) }

  before :all do
    set_resource 'teacher'
  end

  context "new", js: true do
    before do
      visit gaku.teachers_path
      click new_link
      wait_until_visible submit
    end

    it "creates and shows" do
      expect do
        fill_in "teacher_name", with: "John"
        fill_in "teacher_surname", with: "Doe"
        click_button "submit-teacher-button"
        wait_until_invisible form
      end.to change(Gaku::Teacher, :count).by 1

      page.should have_content "John"
      within(count_div) { page.should have_content 'Teachers list(1)' }
      flash_created?
    end

    it { has_validations? }

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context "existing" do
    before do
      teacher
      visit gaku.teachers_path
    end

    context '#edit from show view', js: true do
      before do
        visit gaku.teacher_path(teacher)
        click edit_link
        wait_until_visible modal
      end

      it "edits" do
        fill_in "teacher_surname", with: "Kostova"
        fill_in "teacher_name",    with: "Marta"
        click submit
        wait_until_invisible modal

        page.should have_content "Kostova"
        page.should have_content "Marta"
        page.should_not have_content 'John'
        page.should_not have_content 'Doe'

        teacher.reload
        teacher.name.should eq "Marta"
        teacher.surname.should eq "Kostova"
        flash_updated?
      end

      it 'has validations' do
        fill_in 'teacher_surname', with: ''
        has_validations?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

    end

    context '#edit from index view', js: true do
      before do
        visit gaku.teachers_path
        click edit_link
        wait_until_visible modal
      end

      it "edits" do
        fill_in "teacher_surname", with: "Kostova"
        fill_in "teacher_name",    with: "Marta"
        click submit
        wait_until_invisible modal

        page.should have_content "Kostova"
        page.should have_content "Marta"
        page.should_not have_content 'John'
        page.should_not have_content 'Doe'

        teacher.reload
        teacher.name.should eq "Marta"
        teacher.surname.should eq "Kostova"
        flash_updated?
      end

      it 'has validations' do
        fill_in 'teacher_surname', with: ''
        has_validations?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end
    end

    it 'deletes', js: true do
      visit gaku.teacher_path(teacher2)
      teacher_count = Gaku::Teacher.count
      page.should have_content "#{teacher2.name}"

      expect do
        click '#delete-teacher-link'
        within(modal) { click_on "Delete" }
        accept_alert
        wait_until { flash_destroyed? }
      end.to change(Gaku::Teacher, :count).by -1

      page.should_not have_content "#{teacher2.name}"
      within(count_div) { page.should_not have_content 'Teachers list(#{teacher_count - 1})' }
      current_path.should eq gaku.teachers_path
    end

    context "when select back btn" do
      it 'returns to index view' do
        visit gaku.teacher_path(teacher2)
        click_on('Back')
        page.current_path.should eq gaku.teachers_path
      end
    end

  end

end
