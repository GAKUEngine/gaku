module Gaku
  class CourseEnrollmentsController < GakuController

    load_and_authorize_resource :course_enrollment, :class => Gaku::CourseEnrollment

    include EnrollmentsController

  end
end
