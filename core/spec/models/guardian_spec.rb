require 'spec_helper'

describe Gaku::Guardian do

  context "validations" do
  	let(:guardian) { stub_model(Gaku::Guardian) }

    it { should belong_to(:user) }
    it { should have_many(:addresses) }
    it { should have_and_belong_to_many(:students) }
    it { should have_many(:contacts) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :surname }
    it { should allow_mass_assignment_of :name_reading }
    it { should allow_mass_assignment_of :surname_reading }
    it { should allow_mass_assignment_of :relationship }
    it { should allow_mass_assignment_of :contacts }
    it { should allow_mass_assignment_of :contacts_attributes }

    it { should accept_nested_attributes_for(:contacts).allow_destroy(true) }

    it "errors when name is nil" do
      guardian.name = nil
      guardian.should_not be_valid
    end

    it "errors when surname is nil" do
      guardian.surname = nil
      guardian.should_not be_valid
    end
  end

  context 'methods' do
    xit 'primary_contact'
    xit 'primary_address'
  end

end
