module Gaku
  module Grading
    module Single
      class  Calculations

        attr_reader :grading_methods, :students, :exam

        def initialize(grading_methods, student, exam)
          @exam            = exam
          @student         = student
          @grading_methods = grading_methods
        end

        def calculate
          {}.tap do |hash|
            @grading_methods.each do |grading_method|
              grading = grading_types[grading_method.method].constantize.new(@exam, @student, grading_method.criteria)
              hash[grading_method.id] = grading.grade
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
