require 'spec_helper'

describe Gaku::Students::StudentAchievementsController do

  let(:student) { create(:student) }
  let!(:achievement) { create(:achievement) }
  let(:student_achievement) { create(:student_achievement, student: student, achievement: achievement) }

  context 'as admin' do
    before { as :admin }

    context 'JS' do

      describe 'JS GET #index' do
        before do
          student_achievement
          gaku_js_get :index, student_id: student.id
        end

        it { should respond_with 200 }
        it('assigns @student_achievements') { expect(assigns(:student_achievements)).to eq [student_achievement] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'JS GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @student_achievement') { expect(assigns(:student_achievement)).to be_a_new(Gaku::StudentAchievement) }
        it('assigns @achievements') { expect(assigns(:achievements)).to_not be_empty }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, student_achievement: attributes_for(:student_achievement, achievement_id: achievement.id), student_id: student.id
          end

          it 'creates new student_achievement' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::StudentAchievement, :count).by(1)
            end.to change(student.student_achievements, :count).by(1)
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

      describe 'JS GET #edit' do
        before { gaku_js_get :edit, id: student_achievement, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @student_achievement') { expect(assigns(:student_achievement)).to eq student_achievement }
        it('assigns @achievements') { expect(assigns(:achievements)).to_not be_empty }
        it('renders the :edit template') { template? :edit }
      end

      describe 'JS PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: student_achievement, student_achievement: attributes_for(:student_achievement, achievement_id: achievement), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @student_achievement') { expect(assigns(:student_achievement)).to eq student_achievement }
          it('sets flash') { flash_updated? }
          it "changes student_achievement's attributes" do
            student_achievement.reload
            expect(student_achievement.achievement_id).to eq achievement.id
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: student_achievement, student_achievement: attributes_for(:invalid_student_achievement, achievement_id: nil), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @student_achievement') { expect(assigns(:student_achievement)).to eq student_achievement }

          it "does not change student_achievement's attributes" do
            student_achievement.reload
            expect(student_achievement.achievement_id).not_to eq nil
          end
        end
      end

      describe 'JS DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: student_achievement, student_id: student.id }

        it 'deletes the student_achievement' do
          student_achievement
          expect do
            js_delete
          end.to change(Gaku::StudentAchievement, :count).by(-1)
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

    end
  end

end
