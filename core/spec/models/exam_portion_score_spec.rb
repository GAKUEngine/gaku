require 'spec_helper'

describe Gaku::ExamPortionScore do

  describe 'associations' do
    it { should belong_to :exam_portion }
    it { should belong_to :student }
    it { should have_many :attendances }
  end

end
