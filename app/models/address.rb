class Address < ActiveRecord::Base
  
  belongs_to :country
  belongs_to :state
  has_and_belongs_to_many :students

  validates :address1, :city, :country, :presence => true
  validate :state_validate

  attr_accessible :address1, :address2, :city, :zipcode, :state , :state_name

  def self.default
    country = Country.find(Config[:default_country_id]) rescue Country.first
    new({:country => country}, :without_protection => true)
  end

  def state_text
    state.nil? ? state_name : (state.abbr.blank? ? state.name : state.abbr)
  end

  def same_as?(other)
    return false if other.nil?
    attributes.except('id', 'updated_at', 'created_at') == other.attributes.except('id', 'updated_at', 'created_at')
  end

  alias same_as same_as?

  def clone
    self.class.new(self.attributes.except('id', 'updated_at', 'created_at'))
  end

  def ==(other_address)
    self_attrs = self.attributes
    other_attrs = other_address.respond_to?(:attributes) ? other_address.attributes : {}

    [self_attrs, other_attrs].each { |attrs| attrs.except!('id', 'created_at', 'updated_at') }

    self_attrs == other_attrs
  end

  def empty?
    attributes.except('id', 'created_at', 'updated_at', 'country_id').all? { |_, v| v.nil? }
  end


  private

    def state_validate
      # Skip state validation without country (also required)
      # or when disabled by preference
      return if country.blank? #|| Config[:address_requires_state]

      # ensure associated state belongs to country
      if state.present?
        if state.country == country
          self.state_name = nil #not required as we have a valid state and country combo
        else
          if state_name.present?
            self.state = nil
          else
            errors.add(:state, :invalid)
          end
        end
      end

      # ensure state_name belongs to country without states, or that it matches a predefined state name/abbr
      if state_name.present?
        if country.states.present?
          states = country.states.find_all_by_name_or_abbr(state_name)

          if states.size == 1
            self.state = states.first
            self.state_name = nil
          else
            errors.add(:state, :invalid)
          end
        end
      end

      # ensure at least one state field is populated
      errors.add :state, :blank if state.blank? && state_name.blank?
    end
end