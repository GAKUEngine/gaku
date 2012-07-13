require 'spec_helper'

describe Course do

  context "validations" do 
  	it { should have_valid_factory(:course) }
    it { should have_many(:students) }
    it { should have_many(:course_enrollments) }
    it { should belong_to(:syllabus) }
    it { should belong_to(:class_group) }
  end
  
end
# == Schema Information
#
# Table name: courses
#
#  id             :integer         not null, primary key
#  code           :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  faculty_id     :integer
#  syllabus_id    :integer
#  class_group_id :integer
#

