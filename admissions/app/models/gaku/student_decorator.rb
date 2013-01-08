module Gaku
  Student.class_eval do
    has_one :admission

    #default_scope where("admitted != ?", "")
  end
end
