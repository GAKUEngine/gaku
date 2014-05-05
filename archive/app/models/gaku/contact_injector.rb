Gaku::Contact.class_eval do

  has_paper_trail class_name: 'Gaku::Versioning::ContactVersion',
                  on: [:update, :destroy],
                  meta: {
                    join_model: :join_model_name,
                    joined_resource_id: :joined_resource_id
                      }

  default_scope -> { where(deleted: false) }

  def soft_delete
    update_attributes(deleted: true, primary: false)
    decrement_count
  end

  def recover
    update_attribute(:deleted, false)
    increment_count
  end

  def self.deleted
    where(deleted: true)
  end

  def join_model_name
    contactable_type
  end

  def joined_resource_id
    contactable_id
  end

end
