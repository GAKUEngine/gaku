require 'spec_helper'

describe Gaku::EnrollmentStatusType do
	
	context 'validations' do

    it { should validate_presence_of :name }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :is_active }
	end

end