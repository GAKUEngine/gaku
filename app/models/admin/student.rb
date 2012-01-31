class Admin::Student < ActiveRecord::Base
  validates :name, :presence => true
  has_many :school_classes
end
