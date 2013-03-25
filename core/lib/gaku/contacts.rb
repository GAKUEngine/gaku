module Gaku
  module Contacts
    extend ActiveSupport::Concern

    included do
      has_many :contacts, as: :contactable

      def get_primary_contact
        self.contacts.where(:is_primary => true).first
      end

      def contact_widget
        "#{self.get_primary_contact.contact_type}: #{self.get_primary_contact.data}" if self.get_primary_contact
      end
    end

  end
end
