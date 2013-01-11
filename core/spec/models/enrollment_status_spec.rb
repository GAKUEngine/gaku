require 'spec_helper'

describe Gaku::EnrollmentStatus do

  context 'validations' do
    it { should have_many :students }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :is_active }
    it { should allow_mass_assignment_of :immutable }

    it { should validate_presence_of(:name) }
  end
end
