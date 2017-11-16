module Gaku
  class SchoolRole < ActiveRecord::Base
    belongs_to :school_rolable, polymorphic: true, required: false

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
