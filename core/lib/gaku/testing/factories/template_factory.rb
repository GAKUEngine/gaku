include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :template, class: Gaku::Template do
    name 'Roster Template'
    context 'spreadsheet'
    file_file_name { 'sample_roster.ods' }
    file_content_type { 'application/vnd.oasis.opendocument.spreadsheet' }
    #file_file_size { 1024 }
    #file { fixture_file_upload(Rails.root + '../support/sample_roster.ods', 'application/vnd.oasis.opendocument.spreadsheet') }
    locked false

    factory :invalid_template do
      name nil
    end
  end

end
