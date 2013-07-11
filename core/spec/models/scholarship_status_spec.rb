require 'spec_helper'

describe Gaku::ScholarshipStatus do

  describe 'associations' do
    it { should have_many :students }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

end
