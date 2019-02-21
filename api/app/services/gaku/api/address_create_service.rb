class Gaku::Api::AddressCreateService
  prepend SimpleCommand
  attr_accessor :address_params, :addressable

  def initialize(addressable, address_params)
    @addressable = addressable
    @address_params = address_params
  end

  def call
    address =  addressable.addresses.build(build_attributes) do |a|
      a.state = state
    end

    if address.save
      return address
    else
      errors.add(:base, address.errors.full_messages)
    end

  end

  private

  def build_attributes
    address_params.except(:state)
  end

  def state
    @state ||= Gaku::State.find_by!(name: address_params[:state])
  end

  def required_attributes
    {
      name: student_params[:name],
      surname: student_params[:surname],
      birth_date: student_params[:birth_date]
    }
  end
end
