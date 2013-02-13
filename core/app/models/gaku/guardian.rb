module Gaku
  class Guardian < ActiveRecord::Base

    include Person, Addresses, Contacts

    belongs_to :user
    has_and_belongs_to_many :students, :join_table => :gaku_guardians_students

    attr_accessible :relationship

  end
end
