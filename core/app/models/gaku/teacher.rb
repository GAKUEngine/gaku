module Gaku
  class Teacher < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Picture

    belongs_to :user

    paginates_per 25

  end
end
