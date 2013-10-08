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

  end

end

