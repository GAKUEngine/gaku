module Gaku
  module Migrations

    def self.included(_base)
      ActiveRecord::ConnectionAdapters::Table.send :include, TableDefinition
      ActiveRecord::ConnectionAdapters::TableDefinition.send :include, TableDefinition
    end

    module TableDefinition

      def person_fields
        column :name, :string
        column :surname, :string
        column :middle_name, :string
        column :name_reading, :string, default: ''
        column :middle_name_reading, :string ,  default: ''
        column :surname_reading, :string,  default: ''
        column :gender, :boolean
        column :birth_date, :date
      end

      def counters(*fields)
        fields.each do |field|
          column("#{field}_count", :integer, default: 0)
        end
      end

    end
  end
end
