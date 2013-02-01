module Gaku
  class Address < ActiveRecord::Base
    belongs_to :country
    belongs_to :state
    belongs_to :addressable, polymorphic: true

    has_paper_trail :on => [:update, :destroy],
                    :meta => { :join_model  => :join_model_name, :joined_resource_id => :joined_resource_id }

    default_scope :conditions => { :is_deleted => false }

    validates_presence_of :address1, :city, :country

    accepts_nested_attributes_for :country

    attr_accessible :title, :address1, :address2, :city, :zipcode, :state , :state_name,
                    :is_deleted, :past, :country,
                    :country_id, :state_id

    before_save :ensure_first_is_primary, :on => :create


    def make_primary
      self.addressable.addresses.update_all({:is_primary => false}, ['id != ?', id] )
      self.update_attribute(:is_primary, true)
    end

    def primary?
      self.is_primary
    end

    def join_model_name
      self.addressable_type
    end

    def joined_resource_id
      self.addressable_id
    end

    def state_text
      state.nil? ? state_name : (state.abbr.blank? ? state.name : state.abbr)
    end

    def empty?
      attributes.except('id', 'created_at', 'updated_at', 'country_numcode').all? { |_, v| v.nil? }
    end

    private

    def ensure_first_is_primary
      if self.addressable.respond_to?(:addresses)
        self.is_primary = true if self.addressable.addresses.blank?
      end
    end

  end
end
