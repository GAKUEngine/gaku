module Gaku
  class ClassGroups::EnrollmentsController < EnrollmentsController

    before_action :set_enrollmentable

    def index
      @enrollments = @class_group.enrollments.seat_numbered
    end

    def sort
      params['enrollment'].each_with_index do |id, index|
        @class_group.enrollments.find(id).update(seat_number: index.next)
      end
      @enrollments = @class_group.enrollments.seat_numbered
    end

    def destroy
      @enrollments = @class_group.enrollments.seat_numbered
      super
    end

    private

    def set_enrollmentable
      @enrollmentable = Gaku::ClassGroup.find(params[:class_group_id])
      @class_group = @enrollmentable
    end

  end
end
