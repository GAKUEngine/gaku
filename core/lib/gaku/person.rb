module Gaku
  module Person
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name, :surname

      attr_accessible :name, :surname, :name_reading, :surname_reading,
                      :birth_date, :gender


      def to_s
        "#{self.surname} #{self.name}"
      end

      def phonetic_reading
        "#{self.surname_reading} #{self.name_reading}"
      end

    end

  end
end
