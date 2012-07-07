class AddressHistory < ActiveRecord::Base
  # attr_accessible :title, :body
    attr_accessible :address1, :address2, :city, :zipcode, :state , :state_name
    
    belongs_to :country
	  belongs_to :state
	  belongs_to :address

end
