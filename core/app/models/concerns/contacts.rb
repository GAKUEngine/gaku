module Contacts
  extend ActiveSupport::Concern

  included do
    has_many :contacts, as: :contactable

    def get_primary_contact
      contacts.where(primary: true).first
    end

    def contact_widget
      "#{get_primary_contact.contact_type}: #{get_primary_contact.data}" if get_primary_contact
    end
  end
end
