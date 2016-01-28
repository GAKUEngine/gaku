require 'spec_helper'

describe 'Exam Sessions' do

  let(:exam) { create(:exam, name: 'Linux') }
  let(:exam2) { create(:exam, name: 'Ubuntu') }

  let(:exam_session) { create(:exam_session, exam: exam) }

  before(:all) { set_resource 'exam-session' }
  before { as :admin }

  context '#new', js: true do
    before do
      exam
      visit gaku.exams_path
      click '#exam-sessions-tab-link'
      click new_link
    end

    it 'creates new exam' do
      expect do

        select exam.name, from: 'exam_session_exam_id'

        click submit
        flash_created?
      end.to change(Gaku::ExamSession, :count).by 1

      within(table) { has_content? exam.name }
      count? 'Exam sessions list(1)'
      within('#exam-sessions-tab-link') { has_content? 'Exam sessions(1)' }
    end

    it { has_validations? }

  end

  context 'existing' do
    before do
      exam_session
    end

    pending 'edit', js: true do
      before do
        exam2
        visit gaku.edit_exam_session_path(exam_session)
      end

      it 'edits' do
        select exam2.name, from: 'exam_session_exam_id'
        click submit

        flash_updated?

        expect(current_path).to eq gaku.edit_exam_session_path(exam_session)

      end
    end

    pending 'deletes', js: true do
      visit gaku.edit_exam_session_path(exam_session)
      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::ExamSession, :count).by(-1)

      expect(current_path).to eq gaku.exams_path
    end

  end

end
