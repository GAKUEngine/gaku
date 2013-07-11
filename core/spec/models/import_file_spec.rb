require 'spec_helper'

describe Gaku::ImportFile do

  describe 'validations' do
    it { should have_attached_file :data_file }
  end

end
