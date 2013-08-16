require 'spec_helper'
require 'roo'

describe Gaku::Importers::Students::RosterWorker do

  let!(:file) { create :import_file }
  let(:importer) { Gaku::Importers::Students::Roster.new(file, nil) }
  let(:book) { Roo::Spreadsheet.open(File.open(file)) }

  let!(:email) { create(:contact_type, name: 'Email') }
  let!(:phone) { create(:contact_type, name: 'Phone') }


  describe 'initialize' do
    xit 'sets book' do
      importer
      expect(importer.book).to_not be nil
    end
  end

  describe '#process_book' do
    xit 'creates students' do
      expect do
        importer.send(:process_book)
      end.to change(Gaku::Student, :count).by(3)
    end

    xit 'creates contacts' do
      expect do
        importer.send(:process_book)
      end.to change(Gaku::Contact, :count).by(4)
    end

    xit 'creates addresses' do
      expect do
        importer.send(:process_book)
      end.to change(Gaku::Address, :count).by(1)
    end
  end

end
