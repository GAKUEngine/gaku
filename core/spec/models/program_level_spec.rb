require 'spec_helper_models'

describe Gaku::ProgramLevel, type: :model do

  describe 'associations' do
    it { should belong_to :program }
    it { should belong_to :level }
  end

  describe 'validations' do
    it { should validate_presence_of :level }
    # it { should validate_presence_of :program }
  end

end
