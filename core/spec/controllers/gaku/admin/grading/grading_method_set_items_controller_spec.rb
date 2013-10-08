require 'spec_helper'

describe Gaku::Admin::GradingMethodSets::GradingMethodSetItemsController do

  let(:grading_method_set) { create(:grading_method_set) }
  let(:grading_method) { create(:grading_method, name: 'New grading method') }
  let(:grading_method_set_item) { create(:grading_method_set_item, grading_method_set: grading_method_set) }
  let(:invalid_grading_method_set_item) { create(:invalid_grading_method_set_item) }

  context 'as student' do
    before { as :student }

    describe 'XHR #edit' do
      before do
        gaku_js_get :edit,
                    id: grading_method_set_item,
                    grading_method_set_id: grading_method_set
        end

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'XHR #new' do
        before { gaku_js_get :new, grading_method_set_id: grading_method_set }

        it { should respond_with 200 }
        it('assigns @grading_method_set_item') { expect(assigns(:grading_method_set_item)).to be_a_new(Gaku::GradingMethodSetItem) }
        it('renders the :new template') { template? :new }
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create,
                         grading_method_set_item: attributes_for(:grading_method_set_item, grading_method_id: grading_method.id),
                grading_method_set_id: grading_method_set
          end

          it 'creates new grading_method_set_item' do
            expect do
              valid_js_create
            end.to change(Gaku::GradingMethodSetItem, :count).by(1)
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
            gaku_js_post :create,
                         grading_method_set_item: attributes_for(:invalid_grading_method_set_item, grading_method_id: nil),
                grading_method_set_id: grading_method_set
          end

          it 'does not save the new grading_method_set_item' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::GradingMethodSetItem, :count)
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
        before do
          gaku_js_get :edit,
                      id: grading_method_set_item,
                      grading_method_set_id: grading_method_set
        end

        it { should respond_with 200 }
        it('assigns @grading_method_set_item') { expect(assigns(:grading_method_set_item)).to eq grading_method_set_item }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update,
                          id: grading_method_set_item,
                grading_method_set_item: attributes_for(:grading_method_set_item, grading_method_id: grading_method.id),
                grading_method_set_id: grading_method_set
          end

          it { should respond_with 200 }
          it('assigns @grading_method_set_item') { expect(assigns(:grading_method_set_item)).to eq grading_method_set_item }
          it('sets flash') { flash_updated? }
          it "changes grading_method_set_item's attributes" do
            grading_method_set_item.reload
            expect(grading_method_set_item.grading_method).to eq grading_method
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update,
                          id: grading_method_set_item,
                grading_method_set_item: attributes_for(:invalid_grading_method_set_item, grading_method_id: nil),
                grading_method_set_id: grading_method_set
          end

          it { should respond_with 200 }
          it('assigns @grading_method_set_item') { expect(assigns(:grading_method_set_item)).to eq grading_method_set_item }

          it "does not change grading_method_set_item's attributes" do
            grading_method_set_item.reload
            expect(grading_method_set_item.grading_method).not_to eq grading_method
          end
        end
      end

      describe 'XHR DELETE #destroy' do
        let(:js_delete) do
          gaku_js_delete :destroy,
                         id: grading_method_set_item,
              grading_method_set_id: grading_method_set
        end

        it 'deletes the grading_method_set_item' do
          grading_method_set_item
          expect do
            js_delete
          end.to change(Gaku::GradingMethodSetItem, :count).by(-1)
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
