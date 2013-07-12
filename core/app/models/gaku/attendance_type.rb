module Gaku
  class AttendanceType < ActiveRecord::Base
    has_many :attendances

    translates :name

    validates :name, presence: true, uniqueness: true
  end
end
