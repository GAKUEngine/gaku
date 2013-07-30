require 'spec_helper'

describe Gaku::Template do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :context }
    it { should validate_presence_of :file }
    it { should have_attached_file :file }
    it do
      should validate_attachment_content_type(:file)
        .allowing('text/plain',
                  'application/vnd.ms-excel',
                  'application/vnd.oasis.opendocument.spreadsheet',
                  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    end
  end

end
