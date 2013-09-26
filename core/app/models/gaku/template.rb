module Gaku
  class Template < ActiveRecord::Base

    has_attached_file :file

    validates :name, :context, presence: true
    validates :file, presence: true, on: :create

    validates_attachment_content_type :file,
      message: I18n.t(:'template.file_type_error'),
      content_type:
        [
          'text/plain',
          'application/vnd.ms-excel',
          'application/vnd.oasis.opendocument.spreadsheet',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        ]

  end
end
