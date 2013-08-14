module Gaku
  class Teacher < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Picture, Trashable

    belongs_to :user

  end
end
