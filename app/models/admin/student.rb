class Admin::Student < ActiveRecord::Base
  validates :name, :presence => true
end
