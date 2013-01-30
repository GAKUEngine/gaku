module Gaku
  class Achievement < ActiveRecord::Base
  	has_many :student_achievements
    has_many :students, :through => :student_achievements

    belongs_to :external_school_record

    has_attached_file :badge

    attr_accessible :name, :description, :authority, :badge,
                    :external_school_record_id

    validates_presence_of :name

    def to_s
      name
    end

  end
end
