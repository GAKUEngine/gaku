require 'spec_helper'

describe Gaku::Students::GuardiansController do

  let(:guardian) { create(:guardian) }
  let(:student) { create(:student) }

  before do
    student.guardians << guardian
    as :admin
  end

  describe 'GET #soft_delete' do
    let(:get_soft_delete) { gaku_get :soft_delete, id: guardian, student_id: student }

    it 'redirects' do
      get_soft_delete
      should respond_with(302)
    end

    it 'assigns  @guardian' do
      get_soft_delete
      expect(assigns(:guardian)).to eq guardian
    end

    it 'updates :deleted attribute' do
      expect do
        get_soft_delete
        guardian.reload
      end.to change(guardian, :deleted)
    end
  end

  describe 'GET #recovery' do
    let(:get_recovery) { gaku_js_get :recovery, id: guardian, student_id: student }

    it 'is successfull' do
      get_recovery
      should respond_with(200)
    end

    it 'assigns  @guardian' do
      get_recovery
      expect(assigns(:guardian)).to eq guardian
    end

    it 'renders :recovery' do
      get_recovery
      should render_template :recovery
   end

    it 'updates :deleted attribute' do
      guardian.soft_delete
      expect do
        get_recovery
        guardian.reload
      end.to change(guardian, :deleted)
    end
  end


end
