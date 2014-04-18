require 'spec_helper_controllers'

describe Gaku::Admin::TemplatesController do

  let(:template) { create(:template) }
  let(:invalid_template) { create(:invalid_template) }

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
          template
          gaku_get :index
        end

        it { should respond_with 200 }
        it('assigns @templates') { expect(assigns(:templates)).to eq [template] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_patch :update, id: template, template: attributes_for(:template, name: 'Ruby dev')
          end

          it { should respond_with 302 }
          it('redirects') { redirect_to? gaku.admin_templates_path }
          it('assigns @template') { expect(assigns(:template)).to eq template }
          it('sets flash') { flash_updated? }
          it "changes template's attributes" do
            template.reload
            expect(template.name).to eq 'Ruby dev'
          end
        end

        describe 'with invalid attributes' do
          before do
            gaku_patch :update, id: template, template: attributes_for(:invalid_template, name: '')
          end

          it { should respond_with 200 }
          it('assigns @template') { expect(assigns(:template)).to eq template }

          it "does not change template's attributes" do
            template.reload
            expect(template.name).not_to eq ''
          end
        end
      end

      describe 'POST #create' do
        context 'with valid attributes' do
          let(:valid_create) do
            gaku_post :create, template: attributes_for(:template)
          end

          it 'creates new template' do
            expect do
              valid_create
            end.to change(Gaku::Template, :count).by(1)
          end

          it 'renders flash' do
            valid_create
            flash_created?
          end

          it 'increments @count' do
            valid_create
            expect(assigns(:count)).to eq 1
          end
        end

        describe 'with invalid attributes' do
          let(:invalid_create) do
            gaku_post :create, template: attributes_for(:invalid_template)
          end

          it 'does not save the new template' do
            expect do
              invalid_create
            end.to_not change(Gaku::Template, :count)
          end

          it 're-renders the new method' do
            invalid_create
            template? :new
          end

        end
      end

      describe 'GET #edit' do
        before { gaku_get :edit, id: template }

        it { should respond_with 200 }
        it('assigns @template') { expect(assigns(:template)).to eq template }
        it('renders the :edit template') { template? :edit }
      end

    end

    context 'js' do

      describe 'XHR #new' do
        before do
          gaku_js_get :new
        end

        it { should respond_with 200 }
        it('assigns @template') { expect(assigns(:template)).to be_a_new(Gaku::Template) }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR DELETE #destroy' do
        it 'deletes the template' do
          template
          expect do
            gaku_js_delete :destroy, id: template
          end.to change(Gaku::Template, :count).by(-1)
        end

        it 'decrements @count' do
          gaku_js_delete :destroy, id: template
          expect(assigns(:count)).to eq 0
        end

        it 'sets flash' do
          gaku_js_delete :destroy, id: template
          flash_destroyed?
        end
      end

    end

  end
end
