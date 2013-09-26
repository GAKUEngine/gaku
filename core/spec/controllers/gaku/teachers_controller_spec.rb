require 'spec_helper'

describe Gaku::TeachersController do

  before { as :admin }

  let(:teacher) { create(:teacher) }

  describe 'GET #soft_delete' do
    let(:get_soft_delete) { gaku_get :soft_delete, id: teacher }

    it 'redirects' do
      get_soft_delete
      should respond_with(302)
    end

    it 'assigns  @teacher' do
      get_soft_delete
      expect(assigns(:teacher)).to eq teacher
    end

    it 'updates :deleted attribute' do
      expect do
        get_soft_delete
        teacher.reload
      end.to change(teacher, :deleted)
    end
  end

  describe 'GET #recovery' do
    let(:get_recovery) { gaku_js_get :recovery, id: teacher }

    it 'is successfull' do
      get_recovery
      should respond_with(200)
    end

    it 'assigns  @teacher' do
      get_recovery
      expect(assigns(:teacher)).to eq teacher
    end

    it 'renders :recovery' do
      get_recovery
      should render_template :recovery
   end

    it 'updates :deleted attribute' do
      teacher.soft_delete
      expect do
        get_recovery
        teacher.reload
      end.to change(teacher, :deleted)
    end
  end


end
