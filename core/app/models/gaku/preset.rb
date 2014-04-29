module Gaku
  class Preset < ActiveRecord::Base
    store_accessor :time_format_24
    store_accessor :pagination
    store_accessor :person
    store_accessor :student, :increment_foreign_id_code, :last_foreign_id_code
    store_accessor :address
    store_accessor :export_formats

    store_accessor :chooser_fields,
                   :show_name,
                   :show_middle_name,
                   :show_surname,
                   :show_birth_date,
                   :show_gender,
                   :show_user,
                   :show_code,
                   :show_foreign_id_code,
                   :show_enrollment_status,
                   :show_class_name,
                   :show_specialty,
                   :show_admitted,
                   :show_graduated,
                   :show_primary_address,
                   :show_primary_contact,
                   :show_primary_email

    store_accessor :grading

    def self.default
      where(default: true).first
    end

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
