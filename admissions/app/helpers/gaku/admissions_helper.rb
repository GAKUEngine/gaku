module Gaku
  module AdmissionsHelper

    def admission_methods
      #Gaku::Syllabus.all.collect { |s| [s.name, s.id] }
      Gaku::AdmissionMethod.all(:order => 'name') { |s| [s.name, s.id] }
    end
    
    def get_exam_total_points(student, exam)
      return 'res'
    end

  end
end
