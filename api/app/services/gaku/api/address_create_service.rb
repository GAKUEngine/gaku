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
    @state ||= find_state
  end

  def find_state
    result = nil
    Carmen.i18n_backend.available_locales.each do |locale|
      Carmen.i18n_backend.locale = locale
      Carmen::Country.all.each do |country|
        region_result = country.subregions.find do |region|
          region.name == address_params[:state]
        end
        result = region_result if region_result
        break if result
      end
      break if result
    end
    Carmen.i18n_backend.locale = 'en'

    return if result.blank?

    country = Gaku::Country.find_by(iso: result.parent.alpha_2_code)
    return nil unless country
    temp_state = country.states.find_by(abbr: result.code)
  end

  def required_attributes
    {
      name: student_params[:name],
      surname: student_params[:surname],
      birth_date: student_params[:birth_date]
    }
  end
end
