require 'spec_helper_models'
require 'pry'
describe Gaku::SchoolYear do

  describe 'associations' do
    it { should have_many :semesters }
  end

  describe 'validations' do
    it { should validate_presence_of :starting }
    it { should validate_presence_of :ending }

    it 'validation error for ending before after' do
      school_year = Gaku::SchoolYear.create starting: Date.parse('2013-4-8'), ending: Date.parse('2013-4-7')
      expect(school_year).to_not be_valid
      expect(school_year.errors[:base].count).to eq(1)
    end
  end

end
