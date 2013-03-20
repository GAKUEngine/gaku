module Gaku
  class SchoolLevel < ActiveRecord::Base
    attr_accessible :title
    belongs_to :school

    validates :title, :presence => true
  end
end
