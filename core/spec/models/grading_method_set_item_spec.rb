require 'spec_helper'

describe Gaku::GradingMethodSetItem do

  describe 'associations' do
    it { should belong_to :grading_method }
    it { should belong_to :grading_method_set }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:grading_method_id).scoped_to(:grading_method_set_id).with_message('Grading Method already added to Grading Method Set') }
  end
end
