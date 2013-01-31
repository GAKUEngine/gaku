module Gaku
  class StudentVersion < Version
    self.table_name = :gaku_student_versions

    attr_accessible :human_changes
    serialize :human_changes

    before_save :set_human_changes

    private

    def set_human_changes
      human_changes = Hash.new
      self.changeset.keys.each do |key|
        case key

        when 'enrollment_status_id'
          from = EnrollmentStatus.find(self.changeset[key][0]).to_s if self.changeset[key][0]
          to = EnrollmentStatus.find(self.changeset[key][1]).to_s if self.changeset[key][1]
          human_changes[:enrollment_status] = [from, to]

        when 'commute_method_id'
          from = CommuteMethod.find(self.changeset[key][0]).to_s if self.changeset[key][0]
          to = CommuteMethod.find(self.changeset[key][1]).to_s if self.changeset[key][1]
          human_changes[:commute_method] = [from, to]

        when 'scholarship_status_id'
          from = ScholarshipStatus.find(self.changeset[key][0]).to_s if self.changeset[key][0]
          to = ScholarshipStatus.find(self.changeset[key][1]).to_s if self.changeset[key][1]
          human_changes[:scholarship_status] = [from, to]

        else
          from = self.changeset[key][0]
          to = self.changeset[key][1]
          human_changes[key] = [from,to]
        end

      end
      self.human_changes = human_changes
    end

  end
end
