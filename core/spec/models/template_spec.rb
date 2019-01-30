require 'spec_helper_models'

describe Gaku::Template, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :context }
    it { is_expected.to validate_presence_of :file }
    it { is_expected.to have_attached_file :file }
    it do
      expect(subject).to validate_attachment_content_type(:file)
        .allowing('text/plain',
                  'application/vnd.ms-excel',
                  'application/vnd.oasis.opendocument.spreadsheet',
                  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    end
  end
end
