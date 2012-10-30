module Gaku
  Specialty.class_eval do 
    has_many :specialty_applications
  end
end