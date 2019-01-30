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
      i18n_name
    end

    def i18n_name
      carmen_country = Carmen::Country.coded(iso)
      if carmen_country
        carmen_country.name
      else
        name
      end
    end
  end
end
