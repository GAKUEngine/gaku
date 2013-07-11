require 'spec_helper'

describe Gaku::SimpleGrade do

  describe 'associations' do
    it { should belong_to :school }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :name }
  end

end
