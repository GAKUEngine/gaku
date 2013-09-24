module Person
  extend ActiveSupport::Concern

  included do
    validates :name, :surname, presence: true

    def to_s
      "#{self.surname} #{self.name}"
    end

    def phonetic_reading
      "#{self.surname_reading} #{self.name_reading}"
    end

  end

end

