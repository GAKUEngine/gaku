module Gaku
  class Address < ActiveRecord::Base
    belongs_to :country
    belongs_to :state
    belongs_to :campus

    has_many :student_addresses, :dependent => :destroy
    has_many :students, :through => :student_addresses, :dependent => :destroy
    has_many :guardian_addresses, :dependent => :destroy
    has_many :guardians, :through => :guardian_addresses

    has_paper_trail :on => [:update, :destroy],
                    :meta => { :join_model  => :join_model_name, :joined_resource_id => :joined_resource_id }

    validates_presence_of :address1, :city, :country
    #validates_associated :country, :state, :campus

    accepts_nested_attributes_for :country

    attr_accessible :title, :address1, :address2, :city, :zipcode, :state , :state_name,
                    :past, :country, :country_id, :state_id, :student_id

    def join_model_name
      'Gaku::StudentAddress' if StudentAddress.exists?(:address_id => self.id)
    end

    def joined_resource_id
      if StudentAddress.exists?(:address_id => self.id)
        StudentAddress.find_by_address_id(self.id).student_id
      end
    end

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

  end
end
