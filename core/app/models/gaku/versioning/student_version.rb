module Gaku::Versioning
  class StudentVersion < PaperTrail::Version
    self.table_name = :gaku_versioning_student_versions

    serialize :human_changes

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
          common_change('CommuteMethodType', key0, key1)
        when 'scholarship_status_id'
          common_change('ScholarshipStatus', key0, key1)
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

    def common_change(klass_name, key0, key1)
      klass = "Gaku::#{klass_name}".constantize
      from = klass.find(key0).to_s if key0
      to = klass.find(key1).to_s if key1
      @human_changes[klass_name.underscore.to_sym] = [from, to]
    end

  end
end
