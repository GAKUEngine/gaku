module Gaku
  module GradingMethods
    class  BaseMethod
      attr_reader :gradable, :gradable_type, :students, :criteria, :results

      # Pass a gradable object [exam or assignment] and students
      def initialize(gradable, students, criteria = nil)
        @gradable = gradable
        @students = students
        @criteria = criteria
      end
      
      # Obtain graded hash of results
      def grade
        case @gradable_type
        when :exam then
          grade_exam
        when :assignment then
          grade_assignment
        end
      end

      private

      def grade_exam
      end

      def grade_assignment
      end
    end
  end
end
