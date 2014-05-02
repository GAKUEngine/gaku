module Gaku
  class Country < ActiveRecord::Base
    has_many :states, -> { order name: :asc },
             foreign_key: :country_iso,
             primary_key: :iso

    default_scope -> { order('name ASC') }

    validates :name, :iso_name, :iso, presence: true
    validates :iso, uniqueness: true

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end
  end
end
