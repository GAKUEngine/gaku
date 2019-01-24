require 'spec_helper_models'

describe Gaku::GradingMethodConnector, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :gradable }
    it { is_expected.to belong_to :grading_method }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :grading_method_id }
    it { is_expected.to validate_presence_of :gradable_id }
    it { is_expected.to validate_presence_of :gradable_type }
    it { is_expected.to validate_inclusion_of(:gradable_type).in_array(%w[Gaku::Exam Gaku::Course]) }
    it { is_expected.to validate_uniqueness_of(:grading_method_id).scoped_to(%i[gradable_type gradable_id]) }
  end
end
