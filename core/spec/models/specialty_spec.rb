require 'spec_helper'

describe Gaku::Specialty do

  describe 'associations' do
    it { should have_many :student_specialties }
    it { should have_many(:students).through(:student_specialties) }

    it { should have_many(:program_specialties) }
    it { should have_many(:programs).through(:program_specialties) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

end
