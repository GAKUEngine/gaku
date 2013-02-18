require 'spec_helper'

describe Gaku::Role do

  context "validations" do

    it { should have_many :user_roles }
    it { should have_many(:roles).through(:user_roles) }

  	it { should belong_to :class_group_enrollment }
    it { should belong_to :extracurricular_activity_enrollment }
  	it { should belong_to :faculty }

    it { should validate_presence_of :name }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :class_group_enrollment_id }
    it { should allow_mass_assignment_of :extracurricular_activity_enrollment_id }

    it "validates uniqueness of name" do
      FactoryGirl.create(:role, name: 'unique name')
      should validate_uniqueness_of(:name)
    end

  end

end
