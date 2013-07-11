require 'spec_helper'

describe Gaku::ProgramLevel do

  describe 'associations' do
    it { should belong_to :program }
    it { should belong_to :level }
  end

  describe 'validations' do
    it { should validate_presence_of :level_id }
  end

end
