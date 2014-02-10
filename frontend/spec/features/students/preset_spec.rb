require 'spec_helper'

describe 'Students', type: :feature do

  before { as :admin }

  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:student) { create(:student, name: 'John', surname: 'Doe', enrollment_status_code: enrollment_status_admitted.code) }


  context 'existing' do
    before do
      student
    end

    context 'existing preset' do

      context 'enabled' do
        it 'shows name' do
          create(:preset, chooser_fields: {show_name: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.name')).to eq true
          expect(page.has_css?('#students-index td.name')).to eq true
          expect(page.has_text?(student.name)).to eq true
        end

        it 'shows surname' do
          create(:preset, chooser_fields: {show_surname: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.surname')).to eq true
          expect(page.has_css?('#students-index td.surname')).to eq true
          expect(page.has_text?(student.surname)).to eq true
        end

        it 'shows birth_date' do
          create(:preset, chooser_fields: {show_birth_date: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.birth_date')).to eq true
          expect(page.has_css?('#students-index td.birth_date')).to eq true
          expect(page.has_text?(student.birth_date)).to eq true
        end

        it 'shows gender' do
          create(:preset, chooser_fields: {show_gender: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.gender')).to eq true
          expect(page.has_css?('#students-index td.gender')).to eq true
          #expect(page.has_text?(student.gender)).to eq true
        end
      end

      context 'disabled' do
        it "doesn't show name" do
          create(:preset, chooser_fields: {show_name: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.name')).to eq false
          expect(page.has_css?('#students-index td.name')).to eq false
          expect(page.has_text?(student.name)).to eq false
        end

        it "doesn't show surname" do
          create(:preset, chooser_fields: {show_surname: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.surname')).to eq false
          expect(page.has_css?('#students-index td.surname')).to eq false
          expect(page.has_text?(student.surname)).to eq false
        end

        it "doesn't show birth_date" do
          create(:preset, chooser_fields: {show_birth_date: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.birth_date')).to eq false
          expect(page.has_css?('#students-index td.birth_date')).to eq false
          expect(page.has_text?(student.birth_date)).to eq false
        end

        it "doesn't show gender" do
          create(:preset, chooser_fields: {show_gender: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.gender')).to eq false
          expect(page.has_css?('#students-index td.gender')).to eq false
          expect(page.has_text?(student.gender)).to eq false
        end
      end

    end


    context 'missing preset' do
      it "doesn't show name" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.name')).to eq false
        expect(page.has_css?('#students-index td.name')).to eq false
        expect(page.has_text?(student.name)).to eq false
      end

      it "doesn't show surname" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.surname')).to eq false
        expect(page.has_css?('#students-index td.surname')).to eq false
        expect(page.has_text?(student.surname)).to eq false
      end

      it "doesn't show birth_date" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.birth_date')).to eq false
        expect(page.has_css?('#students-index td.birth_date')).to eq false
        expect(page.has_text?(student.birth_date)).to eq false
      end

      it "doesn't show gender" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.gender')).to eq false
        expect(page.has_css?('#students-index td.gender')).to eq false
        expect(page.has_text?(student.gender)).to eq false
      end
    end


  end
end
