module Gaku
  ExamsController.class_eval do
    include TrashableController
  end
end
