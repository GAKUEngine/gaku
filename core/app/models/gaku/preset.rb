module Gaku
  class Preset < ActiveRecord::Base

    store_accessor :pagination
    store_accessor :person
    store_accessor :address
    store_accessor :export_formats
    store_accessor :chooser_fields
    store_accessor :grading

    def self.active
      where(active: true).first
    end

    def self.per_page(key)
      active.pagination[key.to_s].to_i unless active.nil?
    end

    def self.address(key)
      active.address[key.to_s] unless active.nil?
    end

  end
end
