class Teacher < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :email, :birth
end