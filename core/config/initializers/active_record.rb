
class ActiveRecord::Associations::HasManyThroughAssociation
  def insert_record(record, validate = true, raise = false)
    ensure_not_nested

    if record.new_record?
      if raise
        record.save!(:validate => validate)
      else
        return unless record.save(:validate => validate)
      end
    end

    save_through_record(record)
    #update_counter(1)
    record
  end

  def delete_records(records, method)
    ensure_not_nested

    scope = through_association.scoped.where(construct_join_attributes(*records))

    case method
    when :destroy
      count = scope.destroy_all.length
    when :nullify
      count = scope.update_all(source_reflection.foreign_key => nil)
    else
      count = scope.delete_all
    end

    delete_through_records(records)

    if through_reflection.macro == :has_many && update_through_counter?(method)
      update_counter(-count, through_reflection)
    end

    #update_counter(-count)
  end
end
