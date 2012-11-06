module Gaku
  class Achievement < ActiveRecord::Base
  	belongs_to :student

    attr_accessible :name, :description, :student_id
  end
end