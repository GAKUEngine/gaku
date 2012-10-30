module Gaku
  class Achievement < ActiveRecord::Base
  	belongs_to :past_school

    attr_accessible :name, :description, :past_school_id
  end
end