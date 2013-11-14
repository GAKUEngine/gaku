require 'spec_helper'

describe Gaku::StudentSpecialty do

  describe 'associations' do
    it { should belong_to :specialty }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :specialty_id }
    it { should validate_uniqueness_of(:student_id).scoped_to(:specialty_id).with_message(/Specialty already added!/) }
  end

end
