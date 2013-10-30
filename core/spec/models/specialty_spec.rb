require 'spec_helper'

describe Gaku::Specialty do

  describe 'associations' do
    it { should have_many :student_specialties }
    it { should have_many(:students).through(:student_specialties) }

    it { should have_many(:program_specialties) }
    it { should have_many(:programs).through(:program_specialties) }

    it { should belong_to :department }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:specialty) { build(:specialty) }
    specify { specialty.to_s.should eq specialty.name }
  end

end
