require 'spec_helper_models'

describe Gaku::ExtracurricularActivity do

  describe 'associations' do
    it { should have_many :enrollments }
    it { should have_many(:students).through(:enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:extracurricular_activity) { build(:extracurricular_activity) }
    specify { extracurricular_activity.to_s.should eq extracurricular_activity.name }
  end

end
