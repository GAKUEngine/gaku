module Gaku
  class AttendanceType < ActiveRecord::Base
    has_many :attendances

    validates :name, presence: true, uniqueness: true
  end
end
