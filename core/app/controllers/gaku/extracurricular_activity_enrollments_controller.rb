module Gaku
  class ExtracurricularActivityEnrollmentsController < GakuController

    load_and_authorize_resource :extracurricular_activity_enrollment, :class => Gaku::ExtracurricularActivityEnrollment

    include EnrollmentsController

  end
end
