module Gaku
  module Core
    module ClassNameDetector

      def class_name
        "Gaku::#{controller_name.classify}"
      end

      def class_name_minus_enrollment
        "Gaku::#{controller_name.classify.split('Enrollment').first}"
      end

      def class_name_underscored
        controller_name.classify.split('Enrollment').first.underscore
      end

      def class_name_underscored_plural
        class_name_underscored.pluralize
      end

      def enrollment_param
        "#{controller_name.classify.split('Enrollment').first.underscore}_id"
      end

    end
  end
end
