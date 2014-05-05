require 'spec_helper_models'

describe Gaku::GradingMethod do

  describe 'relations' do
    it { should have_one :exam }
    it { should have_one :exam_portion }
    it { should have_one :assignment }

    it { should have_many :simple_grade_types }
    it { should have_many :grading_method_connectors }

    it { should have_many :grading_method_set_items }
    it { should have_many(:grading_method_sets).through(:grading_method_set_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:grading_method) { build(:grading_method) }
    specify { grading_method.to_s.should eq grading_method.name }
  end

end
