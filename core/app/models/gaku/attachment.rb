module Gaku
  class Attachment < ActiveRecord::Base

    include Trashable

    attr_accessible :name, :description, :asset

    belongs_to :attachable, :polymorphic => true

    has_attached_file :asset

    validates_associated :attachable, :message => I18n.t(:'attachment.associated')
    validates_presence_of :name
    validates_attachment :asset, presence: true
  end
end
