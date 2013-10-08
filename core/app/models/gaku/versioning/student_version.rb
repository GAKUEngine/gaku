module Gaku::Versioning
  class StudentVersion < PaperTrail::Version
    self.table_name = :gaku_versioning_student_versions

    serialize :human_changes

    paginates_per Gaku::Preset.default_per_page

    before_save :set_human_changes

    private

    def set_human_changes
      @human_changes = {}
      changeset.keys.each do |key|
        key0 = changeset[key][0]
        key1 = changeset[key][1]

        case key

        when 'enrollment_status_code'
          enrollment_status_code_change(key0, key1)
        when 'commute_method_type_id'
          commute_method_change(key0, key1)
        when 'scholarship_status_id'
          scholarship_status_change(key0, key1)
        else
          @human_changes[key] = [key0, key1]
        end

      end
      self.human_changes = @human_changes
    end

    def enrollment_status_code_change(key0, key1)
      from = Gaku::EnrollmentStatus.where(code: key0).first.to_s if key0
      to = Gaku::EnrollmentStatus.where(code: key1).first.to_s if key1
      @human_changes[:enrollment_status] = [from, to]
    end

    def commute_method_change(key0, key1)
      from = Gaku::CommuteMethodType.find(key0).to_s if key0
      to = Gaku::CommuteMethodType.find(key1).to_s if key1
      @human_changes[:commute_method_type] = [from, to]
    end

    def scholarship_status_change(key0, key1)
      from = Gaku::ScholarshipStatus.find(key0).to_s if key0
      to = Gaku::ScholarshipStatus.find(key1).to_s if key1
      @human_changes[:scholarship_status] = [from, to]
    end

  end
end
