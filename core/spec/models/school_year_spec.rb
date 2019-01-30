require 'spec_helper_models'
describe Gaku::SchoolYear, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :semesters }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :starting }
    it { is_expected.to validate_presence_of :ending }

    it 'validation error for ending before after' do
      school_year = Gaku::SchoolYear.create starting: Date.parse('2013-4-8'), ending: Date.parse('2013-4-7')
      expect(school_year).not_to be_valid
      expect(school_year.errors[:base].count).to eq(1)
    end
  end
end
