require 'spec_helper'

describe Gaku::ExtracurricularActivity do

  describe 'associations' do
    it { should have_many :enrollments }
    it { should have_many(:students).through(:enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

end
