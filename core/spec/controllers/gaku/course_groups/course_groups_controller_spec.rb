require 'spec_helper'

describe Gaku::CourseGroupsController do

  let(:course_group) { create(:course_group) }
  let(:invalid_course_group) { create(:invalid_course_group) }

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          course_group
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @course_groups') { expect(assigns(:course_groups)).to eq [course_group] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'GET #edit' do
        before { gaku_get :edit, id: course_group }

        it { should respond_with 200 }
        it('assigns @course_group') { expect(assigns(:course_group)).to eq course_group }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: course_group, course_group: attributes_for(:course_group, name: 'mobifon')
          end

          it { should respond_with 302 }
          it('assigns @course_group') { expect(assigns(:course_group)).to eq course_group }
          it('sets flash') { flash_updated? }
          it "changes course_group's attributes" do
            course_group.reload
            expect(course_group.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: course_group, course_group: attributes_for(:invalid_course_group, name: '')
          end

          it { should respond_with 302 }
          it('assigns @course_group') { expect(assigns(:course_group)).to eq course_group }

          it "does not change course_group's attributes" do
            course_group.reload
            expect(course_group.name).not_to eq ''
          end
        end
      end

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: course_group }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @course_group' do
          patch_soft_delete
          expect(assigns(:course_group)).to eq course_group
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            course_group.reload
          end.to change(course_group, :deleted)
        end
      end

    end

    context 'js' do

      describe 'JS GET #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @course_group') { expect(assigns(:course_group)).to be_a_new(Gaku::CourseGroup) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, course_group: attributes_for(:course_group)
          end

          it 'creates new course_group' do
            expect do
              valid_js_create
            end.to change(Gaku::CourseGroup, :count).by(1)
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
            gaku_js_post :create, course_group: attributes_for(:invalid_course_group)
          end

          it 'does not save the new course_group' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::CourseGroup, :count)
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


      describe 'JS DELETE #destroy' do
        it 'deletes the course_group' do
          course_group
          expect do
            gaku_js_delete :destroy, id: course_group
          end.to change(Gaku::CourseGroup, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: course_group
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: course_group
          flash_destroyed?
        end
      end

      describe 'JS PATCH #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: course_group }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @course_group' do
          js_patch_recovery
          expect(assigns(:course_group)).to eq course_group
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
       end

        it 'updates :deleted attribute' do
          course_group.soft_delete
          expect do
            js_patch_recovery
            course_group.reload
          end.to change(course_group, :deleted)
        end
      end

    end
  end

end
