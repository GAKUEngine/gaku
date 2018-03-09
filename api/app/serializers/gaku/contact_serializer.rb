module Gaku
  class ContactSerializer < ActiveModel::Serializer
    attributes %i( id data contact_type_id )
    attribute :student_id, if: :student_contact?

    def student_id
      object.contactable_id
    end

    def student_contact?
      object.contactable_type == 'Gaku::Student'
    end
  end
end
