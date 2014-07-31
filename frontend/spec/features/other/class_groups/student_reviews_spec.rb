require 'spec_helper'

describe 'ClassGroup Student Review' do

  before { as :admin }

  let!(:class_group) { create(:class_group) }
  let!(:student) { create(:student) }
  let!(:enrollment) { create(:class_group_enrollment, enrollmentable: class_group, student: student) }
  let!(:semester) { create(:active_semester) }
  let!(:semester_connector) { create(:semester_connector_class_group, semester: semester, semesterable: class_group) }
  let(:student_review_category) { create(:student_review_category) }

  let(:student_review) do
    create(:class_group_student_review, student: student,
                                        student_reviewable: class_group,
                                        student_review_category: student_review_category)
  end
  context 'create', js: true do
    before do
      student_review_category
      visit gaku.edit_class_group_path(class_group)
      click '#semester-attendances-menu a'
    end

    it 'creates and show' do
      expect do
        click '.class-group-student-review-link'
        within('#new-student-review-modal') do
          has_content? "New #{student} review"
          fill_in 'student_review_content', with: 'Excellent student'
          select student_review_category.to_s, from: 'student_review_student_review_category_id'
          click '#submit-new-class-group-student-review-button'
        end
        flash_created?
      end.to change(Gaku::StudentReview, :count).by(1)
      click '.class-group-student-review-link'
      within('#show-student-review-modal') do
        has_content? "#{student} review"
        has_content? 'Excellent student'
      end
    end

  end

  context 'existing', js: true  do
    before do
      student_review
      visit gaku.edit_class_group_path(class_group)
      click '#semester-attendances-menu a'
      click '.class-group-student-review-link'
    end
  #
    it 'update' do
      expect do
        within('#show-student-review-modal') do
          click '.js-edit-link'
        end
        has_content? "Edit #{student} review"
        fill_in 'student_review_content', with: 'Not good student'
        click '#submit-edit-class-group-student-review-button'
        flash_updated?
        student_review.reload
      end.to change(student_review, :content).from('Excellent student').to('Not good student')
      click '.class-group-student-review-link'
      within('#show-student-review-modal') { has_no_content? 'Excellent student' }
    end

    it 'delete' do
      expect do
        click '.delete-link'
        accept_alert
        flash_destroyed?
      end.to change(Gaku::StudentReview, :count).by(-1)
    end
  end
end
