require 'spec_helper'

describe Gaku::ExamsController do

  let(:exam) { create(:exam) }
  let(:invalid_exam) { create(:invalid_exam) }
  let(:department) { create(:department) }

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          exam
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @exams') { expect(assigns(:exams)).to eq [exam] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: exam }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @exam' do
          patch_soft_delete
          expect(assigns(:exam)).to eq exam
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            exam.reload
          end.to change(exam, :deleted)
        end
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: exam, exam: attributes_for(:exam, name: 'mobifon')
          end

          it { should respond_with 302 }
          it('assigns @exam') { expect(assigns(:exam)).to eq exam }
          it('sets flash') { flash_updated? }
          it "changes exam's attributes" do
            exam.reload
            expect(exam.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: exam, exam: attributes_for(:invalid_exam, name: '')
          end

          it { should respond_with 200 }
          it('assigns @exam') { expect(assigns(:exam)).to eq exam }

          it "does not change exam's attributes" do
            exam.reload
            expect(exam.name).not_to eq ''
          end
        end
      end

      describe 'GET #edit' do
        before do
          department
          gaku_get :edit, id: exam
        end

        it { should respond_with 200 }
        it('assigns @exam') { expect(assigns(:exam)).to eq exam }
        it('renders the :edit template') { template? :edit }
        it('assigns @departments') { expect(assigns(:departments)).to eq [department] }
      end

    end

    context 'js' do

      describe 'XHR GET #new' do
        before do
          department
          gaku_js_get :new
        end

        it { should respond_with 200 }
        it('assigns @exam') { expect(assigns(:exam)).to be_a_new(Gaku::Exam) }
        it('renders the :new template') { template? :new }
        it('assigns @departments') { expect(assigns(:departments)).to eq [department] }

      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, exam: attributes_for(:exam)
          end

          it 'creates new exam' do
            expect do
              valid_js_create
            end.to change(Gaku::Exam, :count).by(1)
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
            gaku_js_post :create, exam: attributes_for(:invalid_exam)
          end

          it 'does not save the new exam' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Exam, :count)
          end

          it 're-renders the new method' do
            invalid_js_create
            template? :create
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 0
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the exam' do
          exam
          expect do
            gaku_js_delete :destroy, id: exam
          end.to change(Gaku::Exam, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: exam
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: exam
          flash_destroyed?
        end
      end

      describe 'XHR GET #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: exam }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @exam' do
          js_patch_recovery
          expect(assigns(:exam)).to eq exam
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
       end

        it 'updates :deleted attribute' do
          exam.soft_delete
          expect do
            js_patch_recovery
            exam.reload
          end.to change(exam, :deleted)
        end
      end

    end
  end

end
