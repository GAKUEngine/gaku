module Gaku
  module AdmissionsHelper

    def admission_methods
      #Gaku::Syllabus.all.collect { |s| [s.name, s.id] }
      Gaku::AdmissionMethod.all(:order => 'name') { |s| [s.name, s.id] }
    end

  end
end
