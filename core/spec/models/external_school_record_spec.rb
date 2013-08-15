require 'spec_helper'

describe Gaku::ExternalSchoolRecord do

  describe 'associations' do
    it { should belong_to :school }
    it { should belong_to :student }

    it { should have_many :simple_grades }
    it { should have_many :achievements }
  end

  describe 'validations' do
    it { should validate_presence_of :student }
    it { should validate_presence_of :school }
  end

end
