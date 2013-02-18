module Gaku
  class ClassGroupEnrollmentsController < GakuController

  load_and_authorize_resource :class_group_enrollment, :class => Gaku::ClassGroupEnrollment

  include EnrollmentsController

  end
end
