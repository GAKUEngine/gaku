module Gaku
  class Teacher < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Trashable

    belongs_to :user

    attr_accessible :user_id, :picture

    has_attached_file :picture, :styles => {:thumb => "256x256>"}, :default_url => "/assets/pictures/thumb/missing.png"


  end
end
