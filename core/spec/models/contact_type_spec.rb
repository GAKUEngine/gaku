require 'spec_helper'

describe Gaku::ContactType do

  context "validations" do
    it { should have_many :contacts }

    it { should accept_nested_attributes_for(:contacts).allow_destroy(true) }

    it { should validate_presence_of :name }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :contacts }
    it { should allow_mass_assignment_of :contacts_attributes }
    it { should allow_mass_assignment_of :guardian_id }
  end

end
