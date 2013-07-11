require 'spec_helper'

describe Gaku::ExamSchedule do

  describe 'associations' do
    it { should belong_to :exam_portion }
    it { should belong_to :schedule }
    it { should belong_to :course }
  end

end
