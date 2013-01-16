module Gaku
  class Address < ActiveRecord::Base
    belongs_to :country
    belongs_to :state
    belongs_to :campus



    belongs_to :addressable, polymorphic: true

    # has_paper_trail :on => [:update, :destroy],
                    # :meta => { :join_model  => :join_model_name, :joined_resource_id => :joined_resource_id }

    default_scope :conditions => { :is_deleted => false }


    validates_presence_of :address1, :city, :country
    #validates_associated :country, :state, :campus

    accepts_nested_attributes_for :country

    attr_accessible :title, :address1, :address2, :city, :zipcode, :state , :state_name,
                    :is_deleted, :past, :country,
                    :country_id, :state_id, :student_id

    before_save :ensure_first_primary, :on => :create


    def make_primary
      self.addressable.addresses.update_all(:is_primary => false)
      self.update_attribute(:is_primary, true)
    end


    # def join_model_name
    #   'Gaku::StudentAddress' if StudentAddress.unscoped.exists?(:address_id => self.id)
    # end

    # def joined_resource_id
    #   if StudentAddress.unscoped.exists?(:address_id => self.id)
    #     StudentAddress.unscoped.find_by_address_id(self.id).student_id
    #   end
    # end

    def self.default
      country = Country.find(Config[:default_country_numcode]) rescue Country.first
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
      attributes.except('id', 'created_at', 'updated_at', 'country_numcode').all? { |_, v| v.nil? }
    end

    private

    def ensure_first_primary
      self.is_primary = true if self.addressable.try(:addresses).try(:'blank?')
    end

  end
end
