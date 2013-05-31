module Gaku
  class Address < ActiveRecord::Base
    belongs_to :country
    belongs_to :state
    belongs_to :addressable, polymorphic: true, counter_cache: true

    has_paper_trail on:   [:update, :destroy],
                    meta: {
                            join_model: :join_model_name,
                            joined_resource_id: :joined_resource_id
                          }

    default_scope -> { where(is_deleted: false) }

    validates_presence_of :address1, :city, :country

    accepts_nested_attributes_for :country

    attr_accessible :title, :address1, :address2, :city, :zipcode,
                    :state, :state_name, :state_id, :country, :country_id,
                    :is_deleted, :is_primary, :past

    before_save :ensure_first_is_primary, on: :create

    after_destroy :reset_counter_cache

    def make_primary
      addresses.where('id != ?', id).update_all(is_primary: false)
      update_attribute(:is_primary, true)
      update_address_widget
    end

    def soft_delete
      update_attributes(is_deleted: true, is_primary: false)
      decrement_count
    end

    def recover
      update_attribute(:is_deleted, false)
      increment_count
    end

    def primary?
      is_primary
    end

    def join_model_name
      addressable_type
    end

    def joined_resource_id
      addressable_id
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

    def ensure_first_is_primary
      if addressable.respond_to?(:addresses)
        self.is_primary = true if addresses.blank?
      end
    end

    def update_address_widget
      if addressable.has_attribute? :primary_address
        addressable.update_attribute(:primary_address, addressable.address_widget)
      end
    end

  end
end
