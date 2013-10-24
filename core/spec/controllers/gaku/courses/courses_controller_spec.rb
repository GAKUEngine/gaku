require 'spec_helper'

describe Gaku::CoursesController do

  let(:course) { create(:course) }
  let(:invalid_course) { create(:invalid_course) }

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          course
          gaku_get :index
        end

        it { should respond_with 200 }
        xit('assigns @courses') { expect(assigns(:courses)).to eq [course] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @course') { expect(assigns(:course)).to be_a_new(Gaku::Course) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, course: attributes_for(:course)
          end

          it 'creates new course' do
            expect do
              valid_js_create
            end.to change(Gaku::Course, :count).by(1)
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
            gaku_js_post :create, course: attributes_for(:invalid_course)
          end

          it 'does not save the new course' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Course, :count)
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
        before { gaku_js_get :edit, id: course }

        it { should respond_with 200 }
        it('assigns @course') { expect(assigns(:course)).to eq course }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: course, course: attributes_for(:course, code: 'test')
          end

          it { should respond_with 200 }
          it('assigns @course') { expect(assigns(:course)).to eq course }
          it('sets flash') { flash_updated? }
          it "changes course's attributes" do
            course.reload
            expect(course.code).to eq 'test'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: course, course: attributes_for(:invalid_course, code: '')
          end

          it { should respond_with 200 }
          it('assigns @course') { expect(assigns(:course)).to eq course }

          it "does not change course's attributes" do
            course.reload
            expect(course.name).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the course' do
          course
          expect do
            gaku_js_delete :destroy, id: course
          end.to change(Gaku::Course, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: course
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: course
          flash_destroyed?
        end
      end

    end
  end

end
