require 'spec_helper'

describe Gaku::ExtracurricularActivitiesController do

  let(:extracurricular_activity) { create(:extracurricular_activity) }
  let(:invalid_extracurricular_activity) { create(:invalid_extracurricular_activity) }

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          extracurricular_activity
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @extracurricular_activitys') { expect(assigns(:extracurricular_activities)).to eq [extracurricular_activity] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end


      describe 'GET #edit' do
        before { gaku_get :edit, id: extracurricular_activity }

        it { should respond_with 200 }
        it('assigns @extracurricular_activity') { expect(assigns(:extracurricular_activity)).to eq extracurricular_activity }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: extracurricular_activity, extracurricular_activity: attributes_for(:extracurricular_activity, name: 'mobifon')
          end

          it { should respond_with 302 }
          it('assigns @extracurricular_activity') { expect(assigns(:extracurricular_activity)).to eq extracurricular_activity }
          it('sets flash') { flash_updated? }
          it "changes extracurricular_activity's attributes" do
            extracurricular_activity.reload
            expect(extracurricular_activity.name).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: extracurricular_activity, extracurricular_activity: attributes_for(:invalid_extracurricular_activity, name: '')
          end

          it { should respond_with 200 }
          it('assigns @extracurricular_activity') { expect(assigns(:extracurricular_activity)).to eq extracurricular_activity }

          it "does not change extracurricular_activity's attributes" do
            extracurricular_activity.reload
            expect(extracurricular_activity.name).not_to eq ''
          end
        end
      end

      describe 'PATCH #soft_delete' do
        let(:patch_soft_delete) { gaku_patch :soft_delete, id: extracurricular_activity }

        it 'redirects' do
          patch_soft_delete
          should respond_with(302)
        end

        it 'assigns  @extracurricular_activity' do
          patch_soft_delete
          expect(assigns(:extracurricular_activity)).to eq extracurricular_activity
        end

        it 'updates :deleted attribute' do
          expect do
            patch_soft_delete
            extracurricular_activity.reload
          end.to change(extracurricular_activity, :deleted)
        end
      end
    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @extracurricular_activity') { expect(assigns(:extracurricular_activity)).to be_a_new(Gaku::ExtracurricularActivity) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, extracurricular_activity: attributes_for(:extracurricular_activity)
          end

          it 'creates new extracurricular_activity' do
            expect do
              valid_js_create
            end.to change(Gaku::ExtracurricularActivity, :count).by(1)
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
            gaku_js_post :create, extracurricular_activity: attributes_for(:invalid_extracurricular_activity)
          end

          it 'does not save the new extracurricular_activity' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::ExtracurricularActivity, :count)
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

      describe 'XHR GET #recovery' do
        let(:js_patch_recovery) { gaku_js_patch :recovery, id: extracurricular_activity }

        it 'is successfull' do
          js_patch_recovery
          should respond_with(200)
        end

        it 'assigns  @extracurricular_activity' do
          js_patch_recovery
          expect(assigns(:extracurricular_activity)).to eq extracurricular_activity
        end

        it 'renders :recovery' do
          js_patch_recovery
          should render_template :recovery
       end

        it 'updates :deleted attribute' do
          extracurricular_activity.soft_delete
          expect do
            js_patch_recovery
            extracurricular_activity.reload
          end.to change(extracurricular_activity, :deleted)
        end
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the extracurricular_activity' do
          extracurricular_activity
          expect do
            gaku_js_delete :destroy, id: extracurricular_activity
          end.to change(Gaku::ExtracurricularActivity, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: extracurricular_activity
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: extracurricular_activity
          flash_destroyed?
        end
      end

    end
  end

end
