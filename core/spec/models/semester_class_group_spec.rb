require 'spec_helper'

module Gaku
  describe SemesterClassGroup do
    context "validations" do

      it { should belong_to :semester }
      it { should belong_to :class_group }

      it { should validate_presence_of :semester_id }
      it { should validate_presence_of :class_group_id }

    end
  end
end
