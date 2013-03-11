require 'spec_helper'

describe 'Student Achievements' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:achievement) { create(:achievement) }
  let(:achievement2) { create(:achievement, :name => 'Another achievement') }
  let(:student_achievement) { create(:student_achievement, :student => student, :achievement => achievement) }
  let!(:el) { '#index-student-achievements-link' }

  before :all do
    set_resource 'student-achievement'
  end

  context '#new', :js => true do

    before do
      achievement
      visit gaku.edit_student_path(student)
      click el
      click new_link
      wait_until_visible '#cancel-student-achievement-link'
    end

    it 'create and show' do
      expect do
        select achievement.name, :from => 'student_achievement_achievement_id'
        click submit
        wait_until_invisible form
      end.to change(Gaku::StudentAchievement, :count).by(1)

      within(el) { page.should have_content(achievement.name) }
      within(count_div) { page.should have_content('Achievements list(1)')}
      flash_created?
    end

    it 'cancel create' do
      ensure_cancel_creating_is_working
    end

    it {has_validations?}
    

  end

  context 'existing',  :js => true do
    before do
      achievement2
      student_achievement
      visit gaku.edit_student_path(student)
      click el
    end

    context '#edit' do
      before do
        within(table) { click edit_link }
      end

      it 'edits' do
        select achievement2.name, :from => 'student_achievement_achievement_id'
        click submit

        within(el) do
          page.should have_content(achievement2)
          page.should_not have_content(achievement)
        end

        flash_updated?
      end

      it 'cancel editing' do
        click '.back-link'
        within(table) { page.should have_content(achievement) }
      end
    end

    it 'delete' do
      page.should have_content(achievement)
      within(count_div) { page.should have_content('Achievements list(1)') }
      expect do
        ensure_delete_is_working
      end.to change(Gaku::StudentAchievement, :count).by(-1)

      within(el) { page.should_not have_content(achievement) }
      within(count_div) { page.should have_content('Achievements list') }
      flash_destroyed?
    end
  end
end
