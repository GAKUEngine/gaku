module Gaku
  class SchoolYear < ActiveRecord::Base
    attr_accessible :starting, :ending

    validates_presence_of :starting, :ending
  end
end
