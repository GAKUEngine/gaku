module Gaku
  module Grading
    module Single
      class  Calculations

        attr_reader :grading_methods, :student, :exam, :collection_students

        def initialize(grading_methods, student, exam, collection_students = nil)
          @exam                = exam
          @student             = student
          @grading_methods     = grading_methods
          @collection_students = collection_students
        end

        def calculate
          {}.tap do |hash|
            @grading_methods.each do |grading_method|
              if grading_method.interval?
                grading = Gaku::Grading::Collection::Interval.new(@exam, collection_students, grading_method.criteria )
                hash[grading_method.id] = grading.grade
              else
                grading = grading_types[grading_method.grading_type].constantize.new(@exam, @student, grading_method.criteria)
                hash[grading_method.id] = grading.grade
              end
            end
          end

        end

        private

        def grading_types
          ActiveSupport::HashWithIndifferentAccess.new(
            score: 'Gaku::Grading::Single::Score',
            percentage: 'Gaku::Grading::Single::Percentage',
            ordinal: 'Gaku::Grading::Single::Ordinal'
          )
        end
      end
    end
  end
end
