require 'spec_helper_controllers'

describe Gaku::Students::ExternalSchoolRecordsController do

  let(:student) { create(:student) }
  let!(:school) { create(:school) }
  let(:external_school_record) { create(:external_school_record, student: student, school: school) }

  context 'as admin' do
    before { as :admin }

    context 'JS' do

      describe 'XHR GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }

        it('assigns @external_school_record') do
          expect(assigns(:external_school_record)).to be_a_new(Gaku::ExternalSchoolRecord)
        end

        it('assigns @schools') { expect(assigns(:schools)).to_not be_empty }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create,
                         external_school_record: attributes_for(:external_school_record,
                                                                school_id: school.id,
                                                                student_id: student.id),
                         student_id: student.id
          end

          it 'creates new external_school_record' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::ExternalSchoolRecord, :count).by(1)
            end.to change(student.external_school_records, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create,
                         external_school_record: attributes_for(:invalid_external_school_record, school_id: nil),
                         student_id: student.id
          end

          it 'does not save the new external_school_record' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ExternalSchoolRecord, :count)
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 0
          end
        end

      end

      describe 'XHR GET #edit' do
        before { gaku_js_get :edit, id: external_school_record, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @external_school_record') { expect(assigns(:external_school_record)).to eq external_school_record }
        it('assigns @schools') { expect(assigns(:schools)).to_not be_empty }
        it('renders the :edit template') { template? :edit }
      end

      describe 'XHR PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update,
                          id: external_school_record,
                          external_school_record: attributes_for(:external_school_record, school_id: school),
                          student_id: student.id
          end

          it { should respond_with 200 }

          it('assigns @external_school_record') do
            expect(assigns(:external_school_record)).to eq external_school_record
          end

          it('sets flash') { flash_updated? }
          it "changes external_school_record's attributes" do
            external_school_record.reload
            expect(external_school_record.school_id).to eq school.id
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update,
                          id: external_school_record,
                          external_school_record: attributes_for(:invalid_external_school_record, school_id: nil),
                          student_id: student.id
          end

          it { should respond_with 200 }

          it('assigns @external_school_record') do
            expect(assigns(:external_school_record)).to eq external_school_record
          end

          it "does not change external_school_record's attributes" do
            external_school_record.reload
            expect(external_school_record.school_id).not_to eq nil
          end
        end
      end

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: external_school_record, student_id: student.id }

        it 'deletes the external_school_record' do
          external_school_record
          expect do
            js_delete
          end.to change(Gaku::ExternalSchoolRecord, :count).by(-1)
        end

        it 'decrements @count' do
          js_delete
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          js_delete
          flash_destroyed?
        end
      end

    end
  end

end
