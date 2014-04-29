module Person
  extend ActiveSupport::Concern

  included do

    validates :name, :surname, presence: true

    def to_s
      "#{surname} #{name}"
    end

    def phonetic_reading
      "#{surname_reading} #{name_reading}"
    end

    def age
      Date.today.year - birth_date.year
    end

    ransacker :age do
      Arel::Nodes::SqlLiteral.new(
        "DATE_PART('year', AGE(NOW(), birth_date))"
      )
    end

  end
end
