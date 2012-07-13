require 'spec_helper'

describe ClassGroupEnrollment do

  context "validations" do 
  	it { should have_valid_factory(:class_group_enrollment) }
    it { should belong_to(:class_group) }
    it { should belong_to(:student) }
    it { should have_many(:roles) } 
  end
  
end# == Schema Information
#
# Table name: class_group_enrollments
#
#  id             :integer         not null, primary key
#  class_group_id :integer
#  student_id     :integer
#  seat_number    :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

