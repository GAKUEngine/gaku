require 'spec_helper_models'

describe Gaku::SchoolYear do

  describe 'associations' do
    it { should have_many :semesters }
  end

  describe 'validations' do
    it { should validate_presence_of :starting }
    it { should validate_presence_of :ending }

    it 'validation error for ending before after' do
      school_year = Gaku::SchoolYear.create starting: Date.parse('2013-4-8'), ending: Date.parse('2013-4-7')
      school_year.valid?.should be_false
      school_year.should have(1).error_on(:base)
    end
  end

end
