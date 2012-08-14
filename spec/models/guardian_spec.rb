# == Schema Information
#
# Table name: guardians
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  surname         :string(255)
#  name_reading    :string(255)
#  surname_reading :string(255)
#  relationship    :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Guardian do

  context "validations" do 
  	let(:guardian) { stub_model(Guardian) }

  	it { should have_valid_factory(:guardian) }
    it { should belong_to(:user) }
    it { should have_many(:guardian_addresses) } 
    it { should have_many(:addresses) } 
    it { should have_and_belong_to_many(:students) } 
    it { should have_many(:contacts) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }

    it "errors when name is nil" do
      guardian.name = nil
      guardian.should_not be_valid
    end

    it "errors when surname is nil" do
      guardian.surname = nil
      guardian.should_not be_valid
    end
  end
  
end
