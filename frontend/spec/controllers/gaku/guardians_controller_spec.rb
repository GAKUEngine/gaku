require 'spec_helper_controllers'

describe Gaku::GuardiansController do

  let(:guardian) { create(:guardian) }
  let(:student) { create(:student) }

  context 'as admin' do
    before { as :admin }


    context 'HTML' do

      describe 'DELETE #destroy' do
        let(:delete) { gaku_delete :destroy, id: guardian, student_id: student.id }

        it 'deletes the guardian' do
          guardian
          expect do
            delete
          end.to change(Gaku::Guardian, :count).by(-1)
        end

        it 'decrements @count' do
          delete
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          delete
          flash_destroyed?
        end
      end

      describe 'GET #edit' do
        before { gaku_get :edit, id: guardian, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @guardian') { expect(assigns(:guardian)).to eq guardian }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: guardian, guardian: attributes_for(:guardian, name: 'Test'), student_id: student.id
          end

          it { should respond_with 302 }
          it('redirects') { redirect_to? "/students/#{student.id}/guardians/#{guardian.id}/edit" }
          it('assigns @guardian') { expect(assigns(:guardian)).to eq guardian }
          it('sets flash') { flash_updated? }
          it "changes guardian's attributes" do
            guardian.reload
            expect(guardian.name).to eq 'Test'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: guardian, guardian: attributes_for(:invalid_guardian, name: nil), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @guardian') { expect(assigns(:guardian)).to eq guardian }

          it "does not change guardian's attributes" do
            guardian.reload
            expect(guardian.name).not_to eq nil
          end
        end
      end

    end

    context 'JS' do

      describe 'JS GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @guardian') { expect(assigns(:guardian)).to be_a_new(Gaku::Guardian) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, guardian: attributes_for(:guardian), student_id: student.id
          end

          it 'creates new guardian' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::Guardian, :count).by(1)
            end.to change(student.guardians, :count).by(1)
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
      end

    end
  end

end
