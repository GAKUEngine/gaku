require 'spec_helper'

describe Gaku::Admin::AchievementsController do

  let(:achievement) { create(:achievement) }
  let(:invalid_achivement) { create(:invalid_achivement) }

  context 'as student' do
    before { as :student }

    describe 'GET #index' do
      before { gaku_get :index }

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'html' do
      describe 'GET #index' do
        before do
          achievement
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @achievements') { expect(assigns(:achievements)).to eq [achievement] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_create) do
            gaku_post :create, achievement: attributes_for(:achievement)
          end

          it 'creates new achievement' do
            expect do
              valid_create
            end.to change(Gaku::Achievement, :count).by(1)
          end

          it 'renders flash' do
            valid_create
            flash_created?
          end
        end

        context 'with invalid attributes' do
          let(:invalid_create) do
            gaku_post :create, achievement: attributes_for(:invalid_achievement)
          end

          xit 'does not save the new achievement' do
            expect do
              invalid_create
            end.to_not change(Gaku::Achievement, :count)
          end

          xit 're-renders the new method' do
            invalid_create
            template? :create
          end
        end
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: achievement, achievement: attributes_for(:achievement, name: 'Ruby Champion')
          end

          xit { should respond_with 200 }
          it('assigns @achievement') { expect(assigns(:achievement)).to eq achievement }
          it('sets flash') { flash_updated? }
          it "changes achievement's attributes" do
            achievement.reload
            expect(achievement.name).to eq 'Ruby Champion'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: achievement, achievement: attributes_for(:invalid_achievement, description: 'Ruby Champion')
          end

          xit { should respond_with 200 }
          xit('assigns @achievement') { expect(assigns(:achievement)).to eq achievement }

          xit "does not change achievement's attributes" do
            achievement.reload
            expect(achievement.description).not_to eq 'Ruby Champion'
          end
        end

      end
    end

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new }

        it { should respond_with 200 }
        it('assigns @achievement') { expect(assigns(:achievement)).to be_a_new(Gaku::Achievement) }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do


      end

      describe 'XHR #edit' do
        before { gaku_js_get :edit, id: achievement }

        it { should respond_with 200 }
        it('assigns @achievement') { expect(assigns(:achievement)).to eq achievement }
        it('renders the :edit template') { template? :edit }
      end



      describe 'XHR DELETE #destroy' do
        it 'deletes the achievement' do
          achievement
          expect do
            gaku_js_delete :destroy, id: achievement
          end.to change(Gaku::Achievement, :count).by(-1)
        end

        it 'assigns @count' do
          gaku_js_delete :destroy, id: achievement
          expect(assigns(:count)).to_not be_nil
        end
      end

    end

  end
end
