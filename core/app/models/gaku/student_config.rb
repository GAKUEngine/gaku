module Gaku
  class StudentConfig < ActiveRecord::Base

    def self.active
      where(active: true).first
    end

  end
end