include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :template, class: Gaku::Template do
    name 'Roster Template'
    context 'spreadsheet'
    file { fixture_file_upload(Rails.root + '../support/sample_roster.ods', 'application/vnd.oasis.opendocument.spreadsheet') }
    is_locked 0
  end

end
