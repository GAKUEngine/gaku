require 'spec_helper'

describe EnrollmentStatus do

	context 'validations' do
	  it { should have_valid_factory(:enrollment_status) }
	  it { should belong_to(:enrollment_status_type) } 
	end

end