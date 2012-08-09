# == Schema Information
#
# Table name: grading_methods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  method      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class GradingMethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
