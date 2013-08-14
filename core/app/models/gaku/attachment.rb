module Gaku
  class Attachment < ActiveRecord::Base

    include Trashable

    belongs_to :attachable, polymorphic: true

    has_attached_file :asset

    validates_associated  :attachable,
                          message: I18n.t(:'attachment.associated')

    validates :name, presence: true
    validates :asset, presence: true, on: :create

    def to_s
      name
    end

  end
end
