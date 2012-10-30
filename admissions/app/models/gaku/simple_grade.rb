module Gaku
  class SimpleGrade < ActiveRecord::Base
    attr_accessible :name, :grade
  end
end