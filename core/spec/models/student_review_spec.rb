require 'spec_helper_models'

describe Gaku::StudentReview, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :student }
    it { is_expected.to belong_to :student_review_category }
    it { is_expected.to belong_to :student_reviewable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :student_id }
    it { is_expected.to validate_presence_of :student_review_category_id }
    it { is_expected.to validate_presence_of :student_reviewable_id }
    it { is_expected.to validate_presence_of :student_reviewable_type }
    it { is_expected.to validate_presence_of :content }
    it do
      expect(subject).to validate_uniqueness_of(:student_id).scoped_to(%i[student_reviewable_type student_reviewable_id])
    end
  end
end
