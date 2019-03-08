module Gaku
  class AddressSerializer < ActiveModel::Serializer
    attributes :id, :address1, :address2, :city, :zipcode, :title, :country_id, :state_id
  end
end
