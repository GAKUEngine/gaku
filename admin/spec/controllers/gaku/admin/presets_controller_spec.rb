require 'spec_helper_controllers'

describe Gaku::Admin::PresetsController do

  let(:preset) { create(:preset) }
  let(:country) { create(:country) }

  context 'as student' do
    before { as :student }

    describe 'XHR GET #index' do
      before { gaku_js_get :index }

      it { should respond_with 302 }
      it('redirects') { redirect_to? gaku.root_path }
      it('sets unauthorized flash') { flash_unauthorized? }
    end
  end

  context 'as admin' do
    before { as :admin }

    context 'js' do
      describe 'XHR GET #index' do
        before do
          preset
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('assigns @presets') { expect(assigns(:presets)).to eq [preset] }
        it('assigns @count') { expect(assigns(:count)).to eq 1 }
        it('renders :index template') { template? :index }
      end


      describe 'XHR GET #edit' do
        before { gaku_js_get :edit, id: preset }

        it { should respond_with 200 }
        it('assigns @preset') { expect(assigns(:preset)).to eq preset }
        it('assigns @countries') { expect(assigns(:countries)).to eq [country] }
        it('assigns @per_page_values') { expect(assigns(:per_page_values)).to_not be_empty }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: preset, preset: attributes_for(:preset, name: 'custom')
          end

          it { should respond_with 200 }
          it('assigns @preset') { expect(assigns(:preset)).to eq preset }
          it('sets flash') { flash_updated? }
          it "changes preset's attributes" do
            preset.reload
            expect(preset.name).to eq 'custom'
          end
        end
      end

    end


  end
end
