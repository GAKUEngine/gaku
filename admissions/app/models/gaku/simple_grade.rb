module Gaku
  class SimpleGrade < ActiveRecord::Base
  	belongs_to :past_school

    attr_accessible :name, :grade, :past_school_id
  end
end