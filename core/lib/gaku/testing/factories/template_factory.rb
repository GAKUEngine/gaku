include ActionDispatch::TestProcess

FactoryBot.define do
  factory :template, class: Gaku::Template do
    name { 'Roster Template' }
    context { 'spreadsheet' }
    file do
      fixture_file_upload(Rails.root + '../support/sample_roster.ods',
                          'application/vnd.oasis.opendocument.spreadsheet')
    end
    locked { false }

    factory(:invalid_template) { name { nil } }
  end
end
