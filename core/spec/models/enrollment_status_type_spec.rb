require 'spec_helper'

describe Gaku::EnrollmentStatusType do
	
	context 'validations' do
	  it { should have_valid_factory(:enrollment_status_type) }
	end

end