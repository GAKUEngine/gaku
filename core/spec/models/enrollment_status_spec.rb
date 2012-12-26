require 'spec_helper'

describe Gaku::EnrollmentStatus do

  context 'validations' do
    it { should belong_to(:enrollment_status_type) } 
    it { should belong_to(:student) }

    it { should have_many(:notes) }

    it { should allow_mass_assignment_of :enrollment_status_type_id }
    it { should allow_mass_assignment_of :student_id }
  end

  context 'methods' do
    xit 'history'
    xit 'revert'
  end

end