module Gaku
  class Campus < ActiveRecord::Base

    include Contacts, Picture

    belongs_to :school
    has_one :address, as: :addressable

    validates :name, presence: true

    scope :master, -> { where(is_master: true) }

  end
end
