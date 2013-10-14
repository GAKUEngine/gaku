module Gaku
  class Department < ActiveRecord::Base

    translates :name

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end

  end
end
