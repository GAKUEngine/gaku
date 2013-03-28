module Gaku
  class ClassGroupEnrollmentsController < GakuController

  load_and_authorize_resource :class_group_enrollment, :class => Gaku::ClassGroupEnrollment

  include EnrollmentsController


  def create
    @enrollment = ClassGroupEnrollment.create(params[:class_group_enrollment])
  end

  end
end
