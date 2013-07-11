require 'spec_helper'

describe Gaku::Achievement do

  describe 'associations' do
    it { should have_many :student_achievements }
    it { should have_many(:students).through(:student_achievements) }
    it { should belong_to :external_school_record }
  end

  describe 'validations' do
    it { should have_attached_file :badge }
    it { should validate_presence_of :name }
  end

end
