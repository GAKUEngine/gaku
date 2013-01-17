module Gaku
  Student.class_eval do
    has_one :admission

    #default_scope where("admitted != ?", "")

    def student
      Student.unscoped{ super }
    end
  end
end
