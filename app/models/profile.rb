class Profile < ActiveRecord::Base
  attr_accessible :email, :birth_date
end