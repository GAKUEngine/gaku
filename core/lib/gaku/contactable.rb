module Gaku
  module Contactable
    extend ActiveSupport::Concern

    included do
      has_many :contacts, as: :contactable

      def primary_contact
        self.contacts.where(:is_primary => true).first
      end
      
    end

  end
end
