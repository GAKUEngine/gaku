module Gaku
  ClassGroupsController.class_eval do
    include TrashableController
  end
end
