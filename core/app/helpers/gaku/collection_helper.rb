module Gaku
  module CollectionHelper

=begin
    def grading_methods
      Gaku::GradingMethod.all.collect { |s| [s.name.capitalize, s.id] }
    end

    def enrollment_status_types
      EnrollmentStatusType.includes(:translations).collect { |s| [s.name.capitalize, s.id] }
    end


    def class_groups
      Gaku::ClassGroup.all.collect { |s| [s.name.capitalize, s.id] }
    end

    def commute_method_types
      CommuteMethodType.includes(:translations).collect {|s| [s.name.capitalize, s.id] }
    end


    def syllabuses
      Gaku::Syllabus.all.collect { |s| [s.name, s.id] }
    end

    def countries
      Gaku::Country.all.sort_by(&:name).collect { |s| [s.name, s.id] }
    end

    def courses
      Gaku::Course.includes(:syllabus).collect do |c|
        if c.syllabus_name
          ["#{c.syllabus_name}-#{c.code}", c.id]
        else
          ["#{c.code}", c.id]
        end
      end
    end

    def scholarship_statuses
      ScholarshipStatus.includes(:translations).collect { |p| [ p.name, p.id ] }
    end



    def contact_types
      Gaku::ContactType.all.collect { |ct| [ct.name, ct.id] }
    end

    def enrollment_statuses
      Gaku::EnrollmentStatus.all.collect { |es| [es.name, es.id] }
    end

    def specialties
      Gaku::Specialty.all.collect { |s| [s.name, s.id] }
    end

    def achievements
      Gaku::Achievement.all.collect { |a| [a.name, a.id] }
    end

    def schools
      Gaku::School.all.collect { |s| [s.name, s.id] }
    end

    def school_levels
      Gaku::School.primary.school_levels.collect { |sl| [sl.title, sl.id] }
    end

    def levels
      Gaku::Level.all.collect { |l| [l.name, l.id] }
    end



    def roles
      Gaku::Role.all
    end

    def semesters
      Gaku::Semester.all.collect { |s| ["#{s.starting} / #{s.ending}" ,s.id] }
    end
=end


  end
end
