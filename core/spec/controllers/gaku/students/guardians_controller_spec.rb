require 'spec_helper'

describe Gaku::Students::GuardiansController do

  let(:guardian) { create(:guardian) }
  let(:student) { create(:student) }

  context 'as admin' do
    before { as :admin }


    context 'HTML' do

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

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: guardian, student_id: student }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it('redirects') do
          patch_soft_delete
          redirect_to? "/students/#{student.id}/edit"
        end

        it 'assigns  @guardian' do
          patch_soft_delete
          expect(assigns(:guardian)).to eq guardian
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            guardian.reload
          end.to change(guardian, :deleted)
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


      describe 'JS DELETE #destroy' do
        let(:js_delete) { gaku_js_delete :destroy, id: guardian, student_id: student.id }

        it 'deletes the guardian' do
          guardian
          expect do
            js_delete
          end.to change(Gaku::Guardian, :count).by(-1)
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

      describe 'JS PATCH #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: guardian, student_id: student }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @guardian' do
          js_patch_recovery
          expect(assigns(:guardian)).to eq guardian
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
       end

        it 'updates :deleted attribute' do
          guardian.soft_delete
          expect do
            js_patch_recovery
            guardian.reload
          end.to change(guardian, :deleted)
        end
      end

    end
  end

end
