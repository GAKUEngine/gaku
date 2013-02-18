require 'spec_helper'

describe Gaku::Achievement do

  context "validations" do
    it { should have_many :student_achievements }
    it { should have_many(:students).through(:student_achievements) }

    it { should belong_to :external_school_record }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :authority }
    it { should allow_mass_assignment_of :badge }

    it { should have_attached_file :badge }

    it { should validate_presence_of :name }
  end

end
