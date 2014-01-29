require 'spec_helper_controllers'

describe Gaku::Students::BadgesController do

  let(:student) { create(:student) }
  let!(:badge_type) { create(:badge_type) }
  let(:badge) { create(:badge, student: student, badge_type: badge_type) }

  context 'as admin' do
    before { as :admin }

    context 'JS' do

      describe 'JS GET #index' do
        before do
          badge
          gaku_js_get :index, student_id: student.id
        end

        it { should respond_with 200 }
        it('assigns @badges') { expect(assigns(:badges)).to eq [badge] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'JS GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @badge') { expect(assigns(:badge)).to be_a_new(Gaku::Badge) }
        it('assigns @badge_types') { expect(assigns(:badge_types)).to_not be_empty }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, badge: attributes_for(:badge, badge_type_id: badge_type.id), student_id: student.id
          end

          it 'creates new badge' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::Badge, :count).by(1)
            end.to change(student.badges, :count).by(1)
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
        before { gaku_js_get :edit, id: badge, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @badge') { expect(assigns(:badge)).to eq badge }
        it('assigns @badge_types') { expect(assigns(:badge_types)).to_not be_empty }
        it('renders the :edit template') { template? :edit }
      end

      describe 'JS PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: badge, badge: attributes_for(:badge, badge_type_id: badge_type), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @badge') { expect(assigns(:badge)).to eq badge }
          it('sets flash') { flash_updated? }
          it "changes badge's attributes" do
            badge.reload
            expect(badge.badge_type_id).to eq badge_type.id
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: badge, badge: attributes_for(:invalid_badge, badge_type_id: nil), student_id: student.id
          end

          it { should respond_with 200 }
          it('assigns @badge') { expect(assigns(:badge)).to eq badge }

          it "does not change badge's attributes" do
            badge.reload
            expect(badge.badge_type_id).not_to eq nil
          end
        end
      end

      describe 'JS DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: badge, student_id: student.id }

        it 'deletes the badge' do
          badge
          expect do
            js_delete
          end.to change(Gaku::Badge, :count).by(-1)
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
