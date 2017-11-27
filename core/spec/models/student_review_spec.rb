require 'spec_helper_models'

describe Gaku::StudentReview, type: :model do

  describe 'relations' do
    it { should belong_to :student }
    it { should belong_to :student_review_category }
    it { should belong_to :student_reviewable }
  end

describe 'validations' do
    it { should validate_presence_of :student_id}
    it { should validate_presence_of :student_review_category_id }
    it { should validate_presence_of :student_reviewable_id }
    it { should validate_presence_of :student_reviewable_type }
    it { should validate_presence_of :content }
    it do
      should validate_uniqueness_of(:student_id).scoped_to([:student_reviewable_type, :student_reviewable_id])
    end
  end


end
