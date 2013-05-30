module Gaku
  class AttendanceType < ActiveRecord::Base
    has_many :attendances

    translates :name

    validates :name, presence: true, uniqueness: true

    attr_accessible :name, :color_code, :counted_absent, :disable_credit,
                    :credit_rate, :auto_credit
  end
end
