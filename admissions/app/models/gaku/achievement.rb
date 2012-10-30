module Gaku
  class Achievement < ActiveRecord::Base
    attr_accessible :name, :description
  end
end