class Schedule < ActiveRecord::Base
  attr_accessible :start, :stop, :repeat 
end