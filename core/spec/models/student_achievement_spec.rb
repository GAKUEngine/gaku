require 'spec_helper'

describe Gaku::StudentAchievement do

  context "validations" do
    it { should belong_to :achievement }
    it { should belong_to :student }

    it { should allow_mass_assignment_of :student_id }
    it { should allow_mass_assignment_of :achievement_id }

    it { should validate_presence_of :student_id }
    it { should validate_presence_of :achievement_id }
  end

end
