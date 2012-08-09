# == Schema Information
#
# Table name: contact_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe ContactType do

  context "validations" do 
  	it { should have_valid_factory(:contact_type) }
    it { should have_many(:contacts) }
  end
  
end
