module Gaku
  class Attachment < ApplicationRecord
    belongs_to :attachable, polymorphic: true, required: false

    has_attached_file :asset

    validates_associated :attachable, message: I18n.t(:'attachment.associated')

    validates :name, presence: true
    validates :asset, presence: true, on: :create
    do_not_validate_attachment_file_type :asset
    validates_attachment_presence :asset

    def to_s
      name
    end
  end
end
