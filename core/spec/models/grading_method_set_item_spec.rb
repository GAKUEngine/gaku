require 'spec_helper_models'

describe Gaku::GradingMethodSetItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :grading_method }
    it { is_expected.to belong_to :grading_method_set }
  end

  describe 'validations' do
    it do
      expect(subject).to validate_uniqueness_of(:grading_method_id)
        .scoped_to(:grading_method_set_id)
        .with_message('Grading Method already added to Grading Method Set')
    end

    it { is_expected.to validate_presence_of :grading_method_id }
    it { is_expected.to validate_presence_of :grading_method_set_id }
  end
end
