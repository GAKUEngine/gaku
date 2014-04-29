module Gaku
  class Address < ActiveRecord::Base
    belongs_to :country
    belongs_to :state
    belongs_to :addressable, polymorphic: true, counter_cache: true

    scope :deleted,   -> { where(deleted: true) }
    scope :students,  -> { where(addressable_type: 'Gaku::Student') }
    scope :teachers,  -> { where(addressable_type: 'Gaku::Teacher') }
    scope :guardians, -> { where(addressable_type: 'Gaku::Guardian') }

    validates :address1, :country, :city, presence: true

    accepts_nested_attributes_for :country

    before_create :ensure_first_primary, on: :create
    after_save :update_primary_address_field
    after_destroy :reset_counter_cache

    def make_primary
      addresses.where.not(id: id).update_all(primary: false)
      update_attribute(:primary, true)
      update_primary_address_field
    end

    def primary?
      primary
    end

    def self.primary
      where(primary: true).first
    end

    def self.secondary
      where(primary: false)
    end

    def state_text
      if state
        state.abbr.blank? ? state.name : state.abbr
      else
        state_name
      end
    end

    def empty?
      except_fields = %w(id created_at updated_at country_numcode)
      attributes.except(except_fields).all? { |_, v| v.nil? }
    end

    def campus_address?
      addressable_type == 'Gaku::Campus'
    end

    private

    def addresses
      addressable.addresses
    end

    def reset_counter_cache
      unless addressable.instance_of? Gaku::Campus
        addressable.class.reset_counters(addressable.id, :addresses)
      end
    end

    def increment_count
      addressable.class.increment_counter(:addresses_count, addressable.id)
    end

    def decrement_count
      addressable.class.decrement_counter(:addresses_count, addressable.id)
    end

    def ensure_first_primary
      if addressable.respond_to?(:addresses)
        self.primary = true if addressable.addresses.blank?
      end
    end

    def update_primary_address_field
      if addressable && addressable.has_attribute?(:primary_address)
        addressable.update_attribute(:primary_address, addressable.address_widget)
      end
    end
  end
end
