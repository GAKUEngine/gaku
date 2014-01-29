module Gaku
  CoursesController.class_eval do
    include TrashableController
  end
end
