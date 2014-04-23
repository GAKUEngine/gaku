require 'spec_helper_controllers'

describe Gaku::ClassGroupsController do

  let(:class_group) { create(:class_group) }
  let(:invalid_class_group) { create(:invalid_class_group) }

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        let(:class_group_for_semester) { create(:class_group) }
        let(:semester) { create(:semester) }
        let(:semester_class_group) { create(:semester_class_group, semester: semester, class_group: class_group) }

        before do
          class_group
          semester_class_group
          gaku_get :index
        end

        it { should respond_with 200 }
        xit('assigns @class_groups') { expect(assigns(:class_groups)).to eq [semester_class_group] }
        xit('assigns @class_groups_without_semester') { expect(assigns(:class_groups_without_semester)).to eq [class_group] }
        xit('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'GET #edit' do
        before { gaku_get :edit, id: class_group }

        it { should respond_with 200 }
        it('assigns @class_group') { expect(assigns(:class_group)).to eq class_group }
        it('assigns @class_group_course_enrollment') { expect(assigns(:class_group_course_enrollment)).to be_a_new(Gaku::ClassGroupCourseEnrollment) }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: class_group, class_group: attributes_for(:class_group, name: 'mobifon')
          end

          it { should respond_with 302 }
          it('redirects to :edit') { redirect_to? "/class_groups/#{class_group.id}/edit" }
          it('assigns @class_group') { expect(assigns(:class_group)).to eq class_group }
          it('sets flash') { flash_updated? }
          it "changes class_group's attributes" do
            class_group.reload
            expect(class_group.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: class_group, class_group: attributes_for(:invalid_class_group, name: '')
          end

          it { should respond_with 200 }
          it('renders the :edit template') { template? :edit }
          it('assigns @class_group') { expect(assigns(:class_group)).to eq class_group }

          it "does not change class_group's attributes" do
            class_group.reload
            expect(class_group.name).not_to eq ''
          end
        end
      end

    end

    context 'js' do

      describe 'JS #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @class_group') { expect(assigns(:class_group)).to be_a_new(Gaku::ClassGroup) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, class_group: attributes_for(:class_group)
          end

          it 'creates new class_group' do
            expect do
              valid_js_create
            end.to change(Gaku::ClassGroup, :count).by(1)
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
            gaku_js_post :create, class_group: attributes_for(:invalid_class_group)
          end

          it 'does not save the new class_group' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ClassGroup, :count)
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
        it 'deletes the class_group' do
          class_group
          expect do
            gaku_js_delete :destroy, id: class_group
          end.to change(Gaku::ClassGroup, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: class_group
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: class_group
          flash_destroyed?
        end
      end

    end
  end

end
