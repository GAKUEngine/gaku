module Contacts
  extend ActiveSupport::Concern

  included do
    has_many :contacts, as: :contactable

    def primary_contact
      contacts.where(primary: true).first
    end

    def contact_widget
      "#{primary_contact.contact_type}: #{primary_contact.data}" if primary_contact
    end
  end
end
