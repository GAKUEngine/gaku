require 'spec_helper'

describe Profile do

  context "validations" do 
  	let(:profile) { stub_model(Profile) }
  	it { should have_valid_factory(:profile) }
  end
  
end# == Schema Information
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  birth_date :datetime
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

