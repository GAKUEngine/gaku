module Gaku
  TeachersController.class_eval do
    include TrashableController
  end
end
