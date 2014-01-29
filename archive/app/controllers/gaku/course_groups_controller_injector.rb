module Gaku
  CourseGroupsController.class_eval do
    include TrashableController
  end
end
