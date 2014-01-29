require 'spec_helper'

describe 'Student Badges' do

  before(:all) { set_resource 'student-badge' }
  before { as :admin }

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:badge_type) { create(:badge_type) }
  let(:badge_type2) { create(:badge_type, name: 'Another badge type') }
  let(:badge) { create(:badge, student: student, badge_type: badge_type) }
  let!(:el) { '#badges' }

  context 'new', js: true do

    before do
      badge_type
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
      click new_link
    end

    it 'creates' do
      expect do
        expect do
          select badge_type.name, from: 'badge_badge_type_id'
          click submit
          within(el) { has_content? badge_type.name }
        end.to change(Gaku::Badge, :count).by(1)
      end.to change(student.badges, :count).by(1)
      within('#student-badge') { has_content? badge_type.name }
      within('#student-badges-tab-link') { has_content? 'Badges(1)' }

      click '#student-badges-tab-link'
      within('#badges_tab') { has_content? badge_type.name }

      count? 'Badges list(1)'
    end

    it { has_validations? }
  end

  context 'existing',  js: true do
    before do
      badge_type2
      badge
      visit gaku.edit_student_path(student)
      click '#student-academic-tab-link'
      click el
    end

    context 'edit' do
      before { within(table) { click js_edit_link } }

      it 'edits' do
        select badge_type2.name, from: 'badge_badge_type_id'
        click submit

        flash_updated?

        within(el) do
          has_content? badge_type2.name
          has_no_content? badge_type.name
        end

        click '#student-badges-tab-link'
        within('#badges_tab') do
          has_content? badge_type2.name
          has_no_content? badge_type.name
        end


      end
    end

    it 'deletes' do
      has_content? badge_type.name
      count? 'Badges list(1)'
      expect do
        ensure_delete_is_working
        within(el) { has_no_content? badge_type.name }
      end.to change(Gaku::Badge, :count).by(-1)

      count? 'Badges list'
      within('#student-badges-tab-link') { has_content? 'Badges' }

      click '#student-badges-tab-link'
      within('#badges_tab') do
        has_no_content? badge_type.name
      end

    end
  end
end
