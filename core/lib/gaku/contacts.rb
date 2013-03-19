module Gaku
  module Contacts
    extend ActiveSupport::Concern

    included do
      has_many :contacts, as: :contactable

      def primary_contact
        self.contacts.where(:is_primary => true).first
      end

      def contact_widget
        "#{self.primary_contact.contact_type}: #{self.primary_contact.data}" if self.primary_contact
      end
    end

  end
end
