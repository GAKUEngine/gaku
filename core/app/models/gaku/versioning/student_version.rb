module Gaku::Versioning
  class StudentVersion < PaperTrail::Version

    self.table_name = :gaku_versioning_student_versions

    serialize :human_changes

    before_save :set_human_changes

    private

    def set_human_changes
      human_changes = Hash.new
      self.changeset.keys.each do |key|
        key0 = self.changeset[key][0]
        key1 = self.changeset[key][1]

        case key

        when 'enrollment_status_code'
          from = Gaku::EnrollmentStatus.where(code: key0).first.to_s if key0
          to = Gaku::EnrollmentStatus.where(code: key1).first.to_s if key1
          human_changes[:enrollment_status] = [from, to]

        when 'commute_method_type_id'
          from = Gaku::CommuteMethodType.find(key0).to_s if key0
          to = Gaku::CommuteMethodType.find(key1).to_s if key1
          human_changes[:commute_method] = [from, to]

        when 'scholarship_status_id'
          from = Gaku::ScholarshipStatus.find(key0).to_s if key0
          to = Gaku::ScholarshipStatus.find(key1).to_s if key1
          human_changes[:scholarship_status] = [from, to]

        else
          from = key0
          to = key1
          human_changes[key] = [from, to]
        end

      end
      self.human_changes = human_changes
    end

  end
end
