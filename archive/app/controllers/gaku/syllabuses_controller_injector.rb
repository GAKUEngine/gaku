module Gaku
  SyllabusesController.class_eval do
    include TrashableController
  end
end
