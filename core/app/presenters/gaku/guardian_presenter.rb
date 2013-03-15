module Gaku
  class GuardianPresenter < BasePresenter
    presents :guardian

    def primary_address
      "#{guardian.primary_address.city}, #{guardian.primary_address.address1}" if guardian.primary_address
    end

    def primary_contact
      "#{guardian.primary_contact.contact_type}: #{guardian.primary_contact.data}" if guardian.primary_contact
    end

  end
end
