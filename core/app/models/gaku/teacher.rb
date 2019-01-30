module Gaku
  class Teacher < ActiveRecord::Base
    include Pagination
    include Picture
    include Notes
    include Contacts
    include Addresses
    include Person

    belongs_to :user, required: false
  end
end
