require 'spec_helper'

describe Gaku::SyllabusesController do

  let(:syllabus) { create(:syllabus) }
  let(:invalid_syllabus) { create(:invalid_syllabus) }

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          syllabus
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @syllabuses') { expect(assigns(:syllabuses)).to eq [syllabus] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end
    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @syllabus') { expect(assigns(:syllabus)).to be_a_new(Gaku::Syllabus) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, syllabus: attributes_for(:syllabus)
          end

          it 'creates new syllabus' do
            expect do
              valid_js_create
            end.to change(Gaku::Syllabus, :count).by(1)
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
            gaku_js_post :create, syllabus: attributes_for(:invalid_syllabus)
          end

          it 'does not save the new syllabus' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Syllabus, :count)
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

      describe 'XHR #edit' do
        before { gaku_js_get :edit, id: syllabus }

        it { should respond_with 200 }
        it('assigns @syllabus') { expect(assigns(:syllabus)).to eq syllabus }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: syllabus, syllabus: attributes_for(:syllabus, name: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @syllabus') { expect(assigns(:syllabus)).to eq syllabus }
          it('sets flash') { flash_updated? }
          it "changes syllabus's attributes" do
            syllabus.reload
            expect(syllabus.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: syllabus, syllabus: attributes_for(:invalid_syllabus, name: '')
          end

          it { should respond_with 200 }
          it('assigns @syllabus') { expect(assigns(:syllabus)).to eq syllabus }

          it "does not change syllabus's attributes" do
            syllabus.reload
            expect(syllabus.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the syllabus' do
          syllabus
          expect do
            gaku_js_delete :destroy, id: syllabus
          end.to change(Gaku::Syllabus, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: syllabus
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: syllabus
          flash_destroyed?
        end
      end
    end

  end
end
