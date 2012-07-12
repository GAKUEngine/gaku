require 'spec_helper'

describe Role do

  context "validations" do 
  	it { should have_valid_factory(:role) }
  	it { should belong_to(:class_group_enrollment) }
  	it { should belong_to(:faculty) }
  end
  
end# == Schema Information
#
# Table name: roles
#
#  id                        :integer         not null, primary key
#  name                      :string(255)
#  class_group_enrollment_id :integer
#  faculty_id                :integer
#

