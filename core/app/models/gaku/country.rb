module Gaku
  class Country < ActiveRecord::Base

    has_many :states, order: 'name ASC' ,
                      foreign_key: :country_iso,
                      primary_key: :iso

    validates_presence_of :name, :iso_name, :iso

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end

  end
end
