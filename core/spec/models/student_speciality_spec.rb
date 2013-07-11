require 'spec_helper'

describe Gaku::StudentSpecialty do

  context 'associations' do
    it { should belong_to :specialty }
    it { should belong_to :student }
  end

  context 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :specialty_id }
  end

end
