require 'spec_helper'

describe Gaku::NotesController do

  let(:note) { create(:note, notable: student) }
  let(:invalid_note) { build(:invalid_note, notable: student) }
  let!(:student) { create(:student) }

  context 'as admin', type: :note do
    before { as :admin }

    context 'student' do

      describe 'XHR GET #new' do
        before { gaku_js_get :new, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @note') { expect(assigns(:note)).to be_a_new(Gaku::Note) }
        it('assigns @notable') { expect(assigns(:notable)).to eq student }
        it('renders the :new template') { template? :new }
      end

      describe 'XHR POST #create' do
        context 'with valid attributes' do
          let(:valid_js_create) do
            gaku_js_post :create, note: attributes_for(:note), student_id: student.id
          end

          it 'creates new note' do
            expect do
              expect do
                valid_js_create
              end.to change(Gaku::Note, :count).by(1)
            end.to change(student.notes, :count).by(1)
          end

          it 'renders flash' do
            valid_js_create
            flash_created?
          end

          it 'sets @notable' do
            valid_js_create
            expect(assigns(:notable)).to eq student
          end

          it 'increments @count' do
            valid_js_create
            expect(assigns(:count)).to eq 1
          end
        end

        context 'with invalid attributes' do
          let(:invalid_js_create) do
            gaku_js_post :create, note: attributes_for(:invalid_note), student_id: student.id
          end

          it 'does not save the new note' do
            expect do
              invalid_js_create
            end.to_not change(Gaku::Note, :count)
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

      describe 'XHR GET #edit' do
        before { gaku_js_get :edit, id: note.id, student_id: student.id }

        it { should respond_with 200 }
        it('assigns @note') { expect(assigns(:note)).to eq note }
        it('assigns @notable') { expect(assigns(:notable)).to eq student }
        it('renders the :edit template') { template? :edit }
      end

      describe 'PATCH #update' do
        context 'with valid attributes' do
          before do
            gaku_js_patch :update, id: note.id, student_id: student.id, note: attributes_for(:note, title: 'mobifon')
          end

          it { should respond_with 200 }
          it('assigns @note') { expect(assigns(:note)).to eq note }
          it('assigns @notable') { expect(assigns(:notable)).to eq student }
          it('sets flash') { flash_updated? }
          it "changes note's attributes" do
            expect(note.reload.title).to eq 'mobifon'
          end
        end

        context 'with invalid attributes' do
          before do
            gaku_js_patch :update, id: note.id, student_id: student.id, note: attributes_for(:invalid_note, title: '')
          end

          it { should respond_with 200 }
          it('assigns @note') { expect(assigns(:note)).to eq note }
          it "does not change note's attributes" do
            expect(note.reload.title).not_to eq ''
          end
        end
      end

      describe 'XHR DELETE #destroy' do

        let(:js_delete) { gaku_js_delete :destroy, id: note.id, student_id: student.id }

        it 'deletes the note' do
          note
          expect do
            js_delete
          end.to change(Gaku::Note, :count).by(-1)
        end

        it('assigns @notable') do
          js_delete
          expect(assigns(:notable)).to eq student
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
