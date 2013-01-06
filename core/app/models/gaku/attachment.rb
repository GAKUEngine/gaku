module Gaku
  class Attachment < ActiveRecord::Base

    attr_accessible :name, :description, :asset

    belongs_to :attachable, :polymorphic => true

    has_attached_file :asset

    validates_presence_of :name
    validates_associated :attachable
    validates_attachment :asset, presence: true

    default_scope conditions: { is_deleted: false }

  end
end
