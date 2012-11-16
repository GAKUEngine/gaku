# == Schema Information
#
# Table name: enrollment_statuses
#
#  id                        :integer          not null, primary key
#  enrollment_status_type_id :integer
#  student_id                :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
module Gaku
  class EnrollmentStatus < ActiveRecord::Base
    belongs_to :enrollment_status_type
    belongs_to :student

    has_many :notes, as: :notable 


    audited :associated_with => :student
    
    attr_accessible :enrollment_status_type_id, :student_id
  
    def history
      @enrollment_status_types   = EnrollmentStatusType.all
      @enrollment_status_history = Hash.new { |hash,key| hash[key] = {} } 

      self.audits.each_with_index do |audit,i|
        @enrollment_status_history[i][:notes]      = notes_for_audit(audit, i)
        @enrollment_status_history[i][:ended_at]   = audit_end_at(i) unless last_audit?(audit)
        @enrollment_status_history[i][:type_name]  = audit_status_type_name(audit, @enrollment_status_types)      
        @enrollment_status_history[i][:created_at] = audit_created_at(audit)
      end

      return @enrollment_status_history
    end

    def revert
      prev_enrollment_status_type_id = self.audits.last.audited_changes["enrollment_status_type_id"][0]
      self.update_attribute(:enrollment_status_type_id, prev_enrollment_status_type_id)
      self.audits.last(2).each {|s| s.destroy}
    end

    private

    def audit_status_type_name(audit, enrollment_status_types)
      position = audit == self.audits.first ? 0 : 1
      enrollment_status_types.detect {|type| type.id == audit.audited_changes["enrollment_status_type_id"][position] }.name     
    end

    def notes_for_audit(audit, index)
      enrollment_status_notes = []

      self.notes.each do |note|
        ended_at = last_audit?(audit) ? Time.now : self.audits[index + 1].created_at 
        if (audit.created_at..ended_at).cover?(note.created_at)
          enrollment_status_notes.append note
        end             
      end

      return enrollment_status_notes
    end

    def last_audit?(audit)
      audit == self.audits.last
    end

    def audit_created_at(audit)
      audit.created_at.strftime("%Y.%m.%d-%H:%M:%S")
    end
    
    def audit_end_at(index)
      self.audits[index + 1].created_at.strftime("%Y.%m.%d-%H:%M:%S")
    end
  end
end
