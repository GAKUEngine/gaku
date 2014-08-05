require 'spec_helper_controllers'

describe Gaku::StudentSelectionController do

  let(:user) { create(:user) }

  let(:student) { create(:student) }

  context 'as admin' do
    before { as :admin }

    context 'js' do

      describe 'XHR GET #index' do
        before do
          Gaku::StudentSelection.new(Gaku::User.last).add(student)
          gaku_js_get :index
        end

        it { should respond_with 200 }
        it('renders :index template') { template? :index }
        it('assigns @selection') do
           expect(assigns(:selection)).to eq [student]
         end
      end

      describe 'XHR GET #add' do
        before { gaku_js_get :add, id: student.id }

        it { should respond_with 200 }
        it('renders the :add template') { template? :add }
        it('assigns @selection') do
           expect(assigns(:selection)).to eq [student]
        end
      end

      describe 'XHR GET #remove' do
        before do
          Gaku::StudentSelection.new(user).add(student)
          gaku_js_get :remove, id: student.id
        end

        it { should respond_with 200 }
        it('renders the :remove template') { template? :remove }
        it('assigns @selection') do
           expect(assigns(:selection)).to eq []
        end
      end

      describe 'XHR GET #clear' do
        before do
          Gaku::StudentSelection.new(user).add(student)
          gaku_js_get :clear, id: student.id
        end

        it { should respond_with 200 }
        it('renders the :clear template') { template? :clear }
        it('assigns @selection') do
           expect(assigns(:selection)).to eq []
        end
      end

    end
  end

end
