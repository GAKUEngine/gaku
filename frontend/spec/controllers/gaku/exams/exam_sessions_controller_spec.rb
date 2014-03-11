require 'spec_helper_controllers'

describe Gaku::Exams::ExamSessionsController do

  let(:exam) { create(:exam) }
  let(:exam_session) { create(:exam_session) }
  let(:invalid_exam_session) { create(:invalid_exam_session) }

  context 'as student' do
    before do
      exam_session
      as :student
    end

    pending 'GET #edit' do
      before { gaku_get :edit, id: exam_session }

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'XHR #edit' do
        before { gaku_get :edit, id: exam_session }

        it { should respond_with 200 }
        it('assigns @exam_session') { expect(assigns(:exam_session)).to eq exam_session }
        it('renders the :edit template') { template? :edit }
      end

       describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: exam_session, exam_session: attributes_for(:exam_session, name: 'new method')
          end

          it('assigns @exam_session') { expect(assigns(:exam_session)).to eq exam_session }
          it('sets flash') { flash_updated? }
          it { should respond_with 302 }
          it('redirects') { redirect_to? gaku.edit_exam_session_path(exam_session) }
          it "changes exam_session's attributes" do
            exam_session.reload
            expect(exam_session.name).to eq 'new method'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: exam_session, exam_session: attributes_for(:invalid_exam_session, name: '')
          end

          it { should respond_with 200 }
          it('assigns @exam_session') { expect(assigns(:exam_session)).to eq exam_session }

          it "does not change exam_session's attributes" do
            exam_session.reload
            expect(exam_session.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the exam_session' do
          exam_session
          expect do
            gaku_delete :destroy, id: exam_session
          end.to change(Gaku::ExamSession, :count).by(-1)
        end

        it 'sets flash' do
          gaku_delete :destroy, id: exam_session
          flash_destroyed?
        end

        it 'redirect' do
          gaku_delete :destroy, id: exam_session
          redirect_to? gaku.exams_path
        end
      end


    end


    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @exam_session') { expect(assigns(:exam_session)).to be_a_new(Gaku::ExamSession) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            exam
            gaku_js_post :create, exam_session: FactoryGirl.build(:exam_session, exam_id: exam.id).attributes.symbolize_keys
          end

          it 'creates new exam_session' do
            expect do
              valid_js_create
            end.to change(Gaku::ExamSession, :count).by(1)
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
            gaku_js_post :create, exam_session: attributes_for(:invalid_exam_session)
          end

          it 'does not save the new exam_session' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ExamSession, :count)
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
    end

  end
end
