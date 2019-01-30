require 'spec_helper_models'

describe Gaku::GradingMethod, type: :model do
  describe 'relations' do
    it { is_expected.to have_one :exam }
    it { is_expected.to have_one :exam_portion }
    it { is_expected.to have_one :assignment }

    it { is_expected.to have_many :simple_grade_types }
    it { is_expected.to have_many :grading_method_connectors }

    it { is_expected.to have_many :grading_method_set_items }
    it { is_expected.to have_many(:grading_method_sets).through(:grading_method_set_items) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_presence_of :grading_type }
    it { is_expected.to validate_inclusion_of(:grading_type).in_array(Gaku::GradingMethod::Types) }
  end

  describe '#to_s' do
    let(:grading_method) { build(:grading_method) }

    specify { grading_method.to_s.should eq grading_method.name }
  end
end
