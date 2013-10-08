require 'spec_helper'

describe Gaku::Admin::TemplatesController do

  before { as :admin }

  let(:template) { create(:template) }

  describe 'GET #index' do
    it 'is successful' do
      gaku_js_get :index
      response.should be_success
    end

    it 'populates an array of templates' do
      gaku_js_get :index
      assigns(:templates).should eq [template]
    end

    it 'renders the :index view' do
      gaku_js_get :index
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new template to @template' do
      gaku_js_get :new, template_id: template.id
      assigns(:template).should be_a_new(Gaku::Template)
    end

    it 'renders the :new template' do
        gaku_js_get :new, template_id: template.id
        response.should render_template :new
    end
  end

  describe 'POST #create' do

    before(:each) do
      request.env['HTTP_REFERER'] = '/admin/templates'
    end

    context 'with valid attributes' do
      it 'saves the new template in the db' do
        expect do
          gaku_post :create, template: attributes_for(:template)
        end.to change(Gaku::Template, :count).by 1

        controller.should set_the_flash
      end
    end
    context 'with invalid attributes' do
      it 'does not save the new template in the db' do
          expect do
            gaku_post :create, template: { name: '' }
          end.to_not change(Gaku::Template, :count)
      end
    end
  end

  describe 'GET #edit' do
    it 'locates the requested template' do
      gaku_js_get :edit, id: template
      assigns(:template).should eq(template)
    end

    it 'renders the :edit template' do
        gaku_js_get :edit, id: template
        response.should render_template :edit
    end
  end

  describe 'PUT #update' do

    before(:each) do
      request.env['HTTP_REFERER'] = '/admin/templates'
    end

    it 'locates the requested @template' do
      gaku_put :update, id: template,
                        template: attributes_for(:template)
      assigns(:template).should eq(template)
    end

    context 'valid attributes' do
      it 'changes templates attributes' do
        gaku_put :update, id: template,
                          template: attributes_for(:template, name: 'Student template')
        template.reload
        template.name.should eq('Student template')

        controller.should set_the_flash
      end
    end

    context 'invalid attributes' do
      it 'does not change templates attributes' do
        gaku_put :update, id: template,
                          template: attributes_for(:template, name: '')
        template.reload
        template.name.should_not eq('')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the template' do
      template
      expect do
        gaku_delete :destroy, id: template
      end.to change(Gaku::Template, :count).by(-1)

      controller.should set_the_flash
    end
  end

end
