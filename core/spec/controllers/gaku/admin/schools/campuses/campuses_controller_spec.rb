require 'spec_helper'

describe Gaku::Admin::Schools::CampusesController do

  let!(:school) { create(:school) }
  let(:campus) { create(:campus, school_id: school.id) }
  let(:invalid_campus) { create(:ivalid_campus) }

  context 'as admin' do
    before { as :admin }

    context 'html' do

      describe 'GET #edit' do
        before { gaku_get :edit, id: campus, school_id: school.id }

        it { should respond_with 200 }
        it('assigns @campus') { expect(assigns(:campus)).to eq campus }
        it('renders the :edit template') { template? :edit }
      end

      describe 'GET #show' do
        before { gaku_get :show, id: campus, school_id: school.id }

        it { should respond_with 200 }
        it('assigns @campus') { expect(assigns(:campus)).to eq campus }
        it('renders the :show template') { template? :show }
      end


      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: campus, school_id: school.id, campus: attributes_for(:campus, name: 'test')
          end

          it { should respond_with 302 }
          it('redirects to :edit view') { redirect_to? "/admin/schools/#{school.id}/campuses/#{campus.id}/edit"}
          it('assigns @campus') { expect(assigns(:campus)).to eq campus }
          it('sets flash') { flash_updated? }
          it "changes campus's attributes" do
            campus.reload
            expect(campus.name).to eq 'test'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_patch :update, id: campus, school_id: school.id, campus: attributes_for(:campus, name: '')
          end

          it { should respond_with 200 }
          it('assigns @campus') { expect(assigns(:campus)).to eq campus }

          it "does not change campus's attributes" do
            campus.reload
            expect(campus.name).not_to eq ''
          end
        end
      end

    end

    context 'js' do

      describe 'JS #new' do
        before { gaku_js_get :new, school_id: school.id }

        it { should respond_with 200 }
        it('assigns @campus') { expect(assigns(:campus)).to be_a_new(Gaku::Campus) }
        it('renders the :new template') { template? :new }
      end

      describe 'JS POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, school_id: school.id, campus: attributes_for(:campus)
          end

          it 'creates new campus' do
            expect do
              valid_js_create
            end.to change(Gaku::Campus, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 2
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, school_id: school.id, campus: attributes_for(:invalid_campus, name: nil)
          end

          it 'does not save the new campus' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Campus, :count)
          end

          it 're-renders the new method' do
            invalid_js_create
            template? :create
          end

          it "doesn't increment @count" do
            invalid_js_create
            expect(assigns(:count)).to eq 1
          end
        end
      end

      describe 'JS DELETE #destroy' do
        it 'deletes the campus' do
          campus
          expect do
            gaku_js_delete :destroy, id: campus, school_id: school.id
          end.to change(Gaku::Campus, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: campus, school_id: school.id
          expect(assigns(:count)).to eq 1
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: campus, school_id: school.id
          flash_destroyed?
        end
      end

    end
  end

end
