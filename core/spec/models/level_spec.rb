require 'spec_helper'

describe Gaku::Level do

  describe 'associations' do
    it { should validate_presence_of :name }
  end

  describe 'validations' do
    it { should have_many :program_levels }
    it { should have_many(:programs).through(:program_levels) }

    it { should belong_to :school }
  end

end
