require 'spec_helper'
require 'roo'

describe Gaku::Core::Importers::Students::RosterWorker do

  let!(:file) { create :import_file }
  let(:importer) { Gaku::Core::Importers::Students::Roster.new(file, nil) }
  let(:book) { Roo::Spreadsheet.open(File.open(file)) }

  let!(:email) { create(:contact_type, name: 'Email') }
  let!(:phone) { create(:contact_type, name: 'Phone') }


  describe 'initialize' do
    it 'sets book' do
      importer
      expect(importer.book).to_not be nil
    end
  end

  describe '#process_book' do
    it 'creates students' do
      expect do
        importer.send(:process_book)
      end.to change(Gaku::Student, :count).by(3)
    end

    it 'creates contacts' do
      expect do
        importer.send(:process_book)
      end.to change(Gaku::Contact, :count).by(4)
    end

    it 'creates addresses' do
      expect do
        importer.send(:process_book)
      end.to change(Gaku::Address, :count).by(1)
    end
  end

end
