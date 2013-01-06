module Gaku
  class Semester < ActiveRecord::Base
    belongs_to :class_group

    attr_accessible :starting, :ending, :class_group_id

    validates :class_group_id, :uniqueness => {:scope => [:starting, :ending], :message =>  I18n.t('semester.uniqueness')}
    validate :ending_after_starting

    private

    def ending_after_starting
    	if self.starting >= self.ending
  			errors.add(:ending, I18n.t('semester.ending_after_starting'))
    	end
    end
    
  end
end
