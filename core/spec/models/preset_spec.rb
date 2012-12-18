require 'spec_helper'

describe Gaku::Preset do

  context "validations" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :content }
  end

  context 'methods' do
    xit 'save_presets'
    xit 'method_missing'
  end
  
end
