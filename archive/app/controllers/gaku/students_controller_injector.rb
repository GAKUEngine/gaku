module Gaku
  StudentsController.class_eval do
    include TrashableController
  end
end
