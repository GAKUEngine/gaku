module Gaku
  class Admission < ActiveRecord::Base
    belongs_to :student
  end
end
