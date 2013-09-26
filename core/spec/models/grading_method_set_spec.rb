require 'spec_helper'

describe Gaku::GradingMethodSet do

  describe 'relations' do
    it { should have_many(:grading_method_set_items) }
    it { should have_many(:grading_methods).through(:grading_method_set_items) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :name }
  end

  describe '#make_primary' do
    it 'makes primary the first one' do
      grading_method_set1 =  create(:grading_method_set)
      expect(grading_method_set1.primary).to eq true
    end

    it 'keeps primary only one' do
      grading_method_set1 =  create(:grading_method_set, primary: true)
      expect(grading_method_set1.primary).to eq true

      grading_method_set2 =  create(:grading_method_set, primary: false)
      grading_method_set2.make_primary

      expect(grading_method_set1.reload.primary).to eq false
      expect(grading_method_set2.reload.primary).to eq true
    end
  end

end
