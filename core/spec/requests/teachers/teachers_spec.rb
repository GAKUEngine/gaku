require 'spec_helper'

describe 'Teachers' do

  let(:teacher) { create(:teacher, name: 'John', surname: 'Doe') }
  let(:teacher2) { create(:teacher) }

  before(:all) { set_resource 'teacher' }
  before { as :admin }

  context 'new', js: true do
    before do
      visit gaku.teachers_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'teacher_name', with: 'John'
        fill_in 'teacher_surname', with: 'Doe'
        click_button 'submit-teacher-button'
        wait_until_invisible form
      end.to change(Gaku::Teacher, :count).by 1

      has_content? 'John'
      count? 'Teachers list(1)'
      flash_created?
    end

    it { has_validations? }
  end

  context 'existing' do
    before do
      teacher
      visit gaku.teachers_path
    end

    context '#edit from edit view', js: true do
      before { visit gaku.edit_teacher_path(teacher) }

      it 'edits' do
        fill_in 'teacher_surname', with: 'Kostova'
        fill_in 'teacher_name',    with: 'Marta'
        click submit

        flash_updated?

        has_content? 'Kostova'
        has_content? 'Marta'
        has_no_content? 'John'
        has_no_content? 'Doe'

        teacher.reload
        expect(teacher.name).to eq 'Marta'
        expect(teacher.surname).to eq 'Kostova'
      end

      it 'has validations' do
        fill_in 'teacher_surname', with: ''
        has_validations?
      end
    end

    context '#edit from index view', js: true do
      before do
        visit gaku.teachers_path
        click edit_link
        #wait_until_visible modal
      end

      xit 'edits' do
        fill_in 'teacher_surname', with: 'Kostova'
        fill_in 'teacher_name',    with: 'Marta'
        click submit
        wait_until_invisible modal

        page.should have_content 'Kostova'
        page.should have_content 'Marta'
        page.should_not have_content 'John'
        page.should_not have_content 'Doe'

        teacher.reload
        teacher.name.should eq 'Marta'
        teacher.surname.should eq 'Kostova'
        flash_updated?
      end

      xit 'has validations' do
        fill_in 'teacher_surname', with: ''
        has_validations?
      end
    end

    it 'deletes', js: true do
      visit gaku.edit_teacher_path(teacher2)
      teacher_count = Gaku::Teacher.count

      expect do
        click '#delete-teacher-link'
        within(modal) { click_on 'Delete' }
        accept_alert
        wait_until { flash_destroyed? }
      end.to change(Gaku::Teacher, :count).by -1

      page.should_not have_content "#{teacher2.name}"
      within(count_div) { page.should_not have_content 'Teachers list(#{teacher_count - 1})' }
      current_path.should eq gaku.teachers_path
    end

  end

end
