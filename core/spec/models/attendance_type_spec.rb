require 'spec_helper'

describe Gaku::AttendanceType do

  describe 'associations' do
    it { should have_many :attendances }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

end
