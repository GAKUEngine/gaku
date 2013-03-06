require 'spec_helper'
require 'support/requests/avatarable_spec'

describe 'Students in admissions' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:student2) { create(:student, name: 'Susumu', surname: 'Yokota') }
  let(:student3) { create(:student, name: 'Johny', surname: 'Bravo') }

  before :all do
    set_resource "student"
  end

  context "existing", js:true do

    before do
      student
      student2
      student3
      visit gaku.edit_admin_student_path(student)

    end

    context 'when select edit btn' do

      before do
        click edit_link
      end

      xit "edits " do
      end


    end

    context 'when click on back' do

      xit 'returns to index' do
        click_on 'Back'
      end

    end

    context 'avatarable' do

      before { @file_name = 'student_picture' }
      it_behaves_like 'avatarable'

    end


    context 'shows notes' do

    end

    context 'shows guardians' do

    end
  end
end
