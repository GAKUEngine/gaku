module Gaku
  class ContactSerializer < ActiveModel::Serializer
    attributes %i( id data )
    attribute :student_id, if: :student_contact?

    belongs_to :contact_type

    def student_id
      object.contactable_id
    end

    def student_contact?
      object.contactable_type == 'Gaku::Student'
    end
  end
end
