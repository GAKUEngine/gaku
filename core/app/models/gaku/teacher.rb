module Gaku
  class Teacher < ActiveRecord::Base
    include Person, Addresses, Contacts, Notes, Picture, Pagination

    belongs_to :user, required: false
  end
end
