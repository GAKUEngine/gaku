module Gaku
  class Teacher < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Picture, Trashable

    belongs_to :user

    attr_accessible :user_id

  end
end
