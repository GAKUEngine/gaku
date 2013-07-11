require 'spec_helper'

describe Gaku::GradingMethodSet do

  describe 'associations' do
    it { should have_many(:grading_method_set_items) }
    it { should have_many(:grading_methods).through(:grading_method_set_items) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :name }
  end

end
