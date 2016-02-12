require 'spec_helper_controllers'

describe Gaku::Exams::ExamPortionsController do

  let(:exam) { create(:exam) }
  let(:exam_portion) { create(:exam_portion, exam: exam) }
  let(:invalid_exam_portion) { create(:invalid_exam_portion) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, exam_id: exam,
                                   id: exam_portion,
                                   exam_portion: attributes_for(:exam_portion, name: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @exam_portion') { expect(assigns(:exam_portion)).to eq exam_portion }
          it('sets flash') { flash_updated? }
          it "changes exam_portion's attributes" do
            exam_portion.reload
            expect(exam_portion.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: exam_portion,
                                exam_id: exam,
                                exam_portion: attributes_for(:invalid_exam_portion, name: '')
          end

          it { should respond_with 200 }
          it('assigns @exam_portion') { expect(assigns(:exam_portion)).to eq exam_portion }

          pending "does not change exam_portion's attributes" do
            exam_portion.reload
            expect(exam_portion.name).not_to eq ''
          end
        end
      end

      describe 'GET #edit' do
        before { gaku_get :edit, exam_id: exam, id: exam_portion }

        it { should respond_with 200 }
        it('assigns @exam_portion') { expect(assigns(:exam_portion)).to eq exam_portion }
        it('renders the :edit template') { template? :edit }
      end

    end

    context 'js' do

      describe 'XHR GET #new' do
        before { gaku_js_get :new, exam_id: exam }

        it { should respond_with 200 }
        it('assigns @exam_portion') { expect(assigns(:exam_portion)).to be_a_new(Gaku::ExamPortion) }
        it('renders the :new template') { template? :new }

      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, exam_id: exam, exam_portion: attributes_for(:exam_portion)
          end

          it 'creates new exam_portion' do
            expect do
              valid_js_create
            end.to change(Gaku::ExamPortion, :count).by(1)
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
            gaku_js_post :create, exam_id: exam, exam_portion: attributes_for(:invalid_exam_portion)
          end

          it 'does not save the new exam_portion' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ExamPortion, :count)
          end

          it 're-renders the new method' do
            invalid_js_create
            template? :create
          end

          it "doesn't increment @count" do
            invalid_js_create
            # because there are autocreated master portion
            expect(assigns(:count)).to eq 0
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        before do
          exam_portion
        end

        it 'deletes the exam_portion' do
          expect do
            gaku_js_delete :destroy, id: exam_portion.id, exam_id: exam.id
          end.to change(Gaku::ExamPortion, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: exam_portion, exam_id: exam
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: exam_portion, exam_id: exam
          flash_destroyed?
        end
      end

    end
  end

end
