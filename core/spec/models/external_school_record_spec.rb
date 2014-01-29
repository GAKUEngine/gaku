require 'spec_helper_models'

describe Gaku::ExternalSchoolRecord do

  describe 'associations' do
    it { should belong_to :school }
    it { should belong_to :student }

    xit { should have_many :simple_grades }
  end

  describe 'validations' do
    it { should validate_presence_of :student }
    it { should validate_presence_of :school }
  end

end
