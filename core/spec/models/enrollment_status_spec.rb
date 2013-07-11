require 'spec_helper'

describe Gaku::EnrollmentStatus do

  describe 'associations' do
    it { should have_many :students }
  end

  describe 'validations' do
    it { should validate_presence_of :code }
  end

end
