require 'spec_helper'

describe Gaku::GradingMethod do

  describe 'associations' do
  	it { should have_one :exam }
  	it { should have_one :exam_portion }
  	it { should have_one :assignment }

    it { should have_many :grading_method_set_items }
    it { should have_many(:grading_method_sets).through(:grading_method_set_items) }
  end

end
