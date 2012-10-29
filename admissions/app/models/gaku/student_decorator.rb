module Gaku
  Student.class_eval do 
    has_many :admissions
  end
end
