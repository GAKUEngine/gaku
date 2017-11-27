require 'spec_helper_models'

describe Gaku::Program, type: :model do

  describe 'associations' do
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:student_review_category) { build(:student_review_category) }
    specify { student_review_category.to_s.should eq student_review_category.name }
  end

end
