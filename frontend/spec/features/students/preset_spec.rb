require 'spec_helper'

describe 'Students', type: :feature do

  before { as :admin }

  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:student) do
    create(:student, name: 'John',  middle_name: 'Little', surname: 'Doe', enrollment_status_code: enrollment_status_admitted.code)
  end


  context 'existing' do
    before do
      student
    end

    context 'existing preset' do

      context 'enabled' do

        it 'shows code' do
          create(:preset, chooser_fields: {show_code: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.code')).to eq true
          expect(page.has_css?('#students-index td.code')).to eq true
          expect(page.has_text?(student.code)).to eq true
        end

        it 'shows name' do
          create(:preset, chooser_fields: {show_name: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.name')).to eq true
          expect(page.has_css?('#students-index td.name')).to eq true
          expect(page.has_text?(student.name)).to eq true
        end

        it 'shows middle_name' do
          create(:preset, chooser_fields: {show_middle_name: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.middle_name')).to eq true
          expect(page.has_css?('#students-index td.middle_name')).to eq true
          expect(page.has_text?(student.middle_name)).to eq true
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

        it 'shows admitted' do
          create(:preset, chooser_fields: {show_admitted: '1'})
          student.admitted = Time.now
          student.save
          visit gaku.students_path

          expect(page.has_css?('#students-index th.admitted')).to eq true
          expect(page.has_css?('#students-index td.admitted')).to eq true
          expect(page.has_text?(student.admitted)).to eq true
        end

        it 'shows primary_contact' do
          create(:contact, contactable: student)
          create(:preset, chooser_fields: {show_primary_contact: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.primary_contact')).to eq true
          expect(page.has_css?('#students-index td.primary_contact')).to eq true
          expect(page.has_text?(student.primary_contact)).to eq true
        end

        it 'shows primary_address' do
          create(:address, addressable: student)
          create(:preset, chooser_fields: {show_primary_address: '1'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.primary_address')).to eq true
          expect(page.has_css?('#students-index td.primary_address')).to eq true
          expect(page.has_text?(student.primary_address)).to eq true
        end
      end

      context 'disabled' do

        it "doesn't show code" do
          create(:preset, chooser_fields: {show_code: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.code')).to eq false
          expect(page.has_css?('#students-index td.code')).to eq false
          expect(page.has_text?(student.code)).to eq false
        end

        it "doesn't show name" do
          create(:preset, chooser_fields: {show_name: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.name')).to eq false
          expect(page.has_css?('#students-index td.name')).to eq false
          expect(page.has_text?(student.name)).to eq false
        end

        it "doesn't show middle_name" do
          create(:preset, chooser_fields: {show_middle_name: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.middle_name')).to eq false
          expect(page.has_css?('#students-index td.middle_name')).to eq false
          expect(page.has_text?(student.middle_name)).to eq false
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

        it "doesn't show admitted" do
          create(:preset, chooser_fields: {show_admitted: '0'})
          student.admitted = Time.now
          student.save
          visit gaku.students_path

          expect(page.has_css?('#students-index th.admitted')).to eq false
          expect(page.has_css?('#students-index td.admitted')).to eq false
          expect(page.has_text?(student.admitted)).to eq false
        end

        it "doesn't show primary_contact" do
          create(:contact, contactable: student)
          create(:preset, chooser_fields: {show_primary_contact: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.primary_contact')).to eq false
          expect(page.has_css?('#students-index td.primary_contact')).to eq false
          expect(page.has_text?(student.primary_contact)).to eq false
        end

        it "doesn't show primary_address" do
          create(:address, addressable: student)
          create(:preset, chooser_fields: {show_primary_address: '0'})
          visit gaku.students_path

          expect(page.has_css?('#students-index th.primary_address')).to eq false
          expect(page.has_css?('#students-index td.primary_address')).to eq false
          expect(page.has_text?(student.primary_address)).to eq false
        end
      end

    end


    context 'missing preset' do
      it "doesn't show code" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.code')).to eq false
        expect(page.has_css?('#students-index td.code')).to eq false
        expect(page.has_text?(student.code)).to eq false
      end

      it "doesn't show name" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.name')).to eq false
        expect(page.has_css?('#students-index td.name')).to eq false
        expect(page.has_text?(student.name)).to eq false
      end

      it "doesn't show middle_name" do
        visit gaku.students_path
        expect(page.has_css?('#students-index th.middle_name')).to eq false
        expect(page.has_css?('#students-index td.middle_name')).to eq false
        expect(page.has_text?(student.middle_name)).to eq false
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

      it "doesn't show admitted" do
        student.admitted = Time.now
        student.save
        visit gaku.students_path
        expect(page.has_css?('#students-index th.admitted')).to eq false
        expect(page.has_css?('#students-index td.admitted')).to eq false
        expect(page.has_text?(student.admitted)).to eq false
      end

      it "doesn't show primary_contact" do
        create(:contact, contactable: student)
        visit gaku.students_path
        expect(page.has_css?('#students-index th.primary_contact')).to eq false
        expect(page.has_css?('#students-index td.primary_contact')).to eq false
        expect(page.has_text?(student.primary_contact)).to eq false
      end


      it "doesn't show primary_address" do
        create(:address, addressable: student)
        visit gaku.students_path
        expect(page.has_css?('#students-index th.primary_address')).to eq false
        expect(page.has_css?('#students-index td.primary_address')).to eq false
        expect(page.has_text?(student.primary_address)).to eq false
      end
    end


  end
end
