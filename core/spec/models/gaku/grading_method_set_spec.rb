require 'spec_helper'

describe Gaku::GradingMethodSet do
  context "validations" do
    it { should allow_mass_assignment_of :display_deviation }
    it { should allow_mass_assignment_of :display_rank }
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :is_primary }
    it { should allow_mass_assignment_of :rank_order }
    it { should have_many(:grading_method_set_items).order(:position) }
    it { should have_many(:grading_methods).through(:grading_method_set_items) }

    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :name }

  end
end