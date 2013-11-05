require 'spec_helper'

describe 'Student Achievements' do

  before(:all) { set_resource 'student-achievement' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:achievement) { create(:achievement) }
  let(:achievement2) { create(:achievement, name: 'Another achievement') }
  let(:student_achievement) { create(:student_achievement, student: student, achievement: achievement) }
  let!(:el) { '#achievements' }

  context 'new', js: true do

    before do
      achievement
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
      click new_link
      wait_until_visible submit
    end

    it 'creates' do
      expect do
        select achievement.name, from: 'student_achievement_achievement_id'
        click submit
        flash_created?
      end.to change(Gaku::StudentAchievement, :count).by(1)

      within(el) { has_content? achievement.name }
      count? 'Achievements list(1)'
    end

    it { has_validations? }
  end

  context 'existing',  js: true do
    before do
      achievement2
      student_achievement
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        select achievement2.name, from: 'student_achievement_achievement_id'
        click submit

        flash_updated?

        within(el) do
          has_content? achievement2.name
          has_no_content? achievement.name
        end
      end
    end

    it 'deletes' do
      has_content? achievement.name
      count? 'Achievements list(1)'
      expect do
        ensure_delete_is_working
      end.to change(Gaku::StudentAchievement, :count).by(-1)

      flash_destroyed?
      within(el) { has_no_content? achievement.name }
      count? 'Achievements list'
    end
  end
end
