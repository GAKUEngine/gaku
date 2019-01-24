module Gaku
  class Template < ActiveRecord::Base
    has_attached_file :file

    validates_with AttachmentContentTypeValidator,
                   attributes: :file,
                   content_type: ['text/plain',
                                  'application/vnd.ms-excel',
                                  'application/vnd.oasis.opendocument.spreadsheet',
                                  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'],
                   message: I18n.t(:'template.file_type_error')

    validates :name, :context, presence: true
    validates :file, presence: true, on: :create
  end
end
