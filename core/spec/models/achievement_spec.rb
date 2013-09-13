require 'spec_helper'

describe Gaku::Achievement do

  describe 'relations' do
    it { should have_many :student_achievements }
    it { should have_many(:students).through(:student_achievements) }
    it { should belong_to :external_school_record }
  end

  describe 'validations' do
    it { should have_attached_file :badge }
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:achievement) { build(:achievement) }
    specify { achievement.to_s.should eq achievement.name }
  end

end
