require 'spec_helper'

describe Gaku::ClassGroupEnrollmentsController do

  as_admin

  let(:student1) { create(:student) }
  let(:student2) { create(:student) }
  let(:class_group) { create(:class_group) }

  describe "POST #enroll_students" do
    context 'one student' do

      let(:attributes) { { class_group_id: class_group.id, selected_students: ["student-#{student1.id}"], source: "class_groups" } }

      it 'saves to db' do
        expect do
          gaku_js_post :enroll_students, attributes
        end.to change(Gaku::ClassGroupEnrollment, :count).by 1

        should respond_with(:success)
      end

      context 'with params[:source] = class_groups' do
        before(:each) { gaku_js_post :enroll_students, attributes.merge(source: 'class_groups') }

        it('assigns @class_group') { assigns(:class_group).should eq class_group }
        it('assigns @count') { assigns(:count).should eq 1 }
        it('renders enroll_students') { should render_template :enroll_students }
      end

      context 'without params[:source]' do
        before(:each) { gaku_js_post :enroll_students, attributes }

        it('renders gaku/shared/_flash partial') { should render_template 'gaku/shared/_flash' }
      end

      context 'multiple students' do

        let(:attributes) do
          {
            class_group_id: class_group.id,
            selected_students: ["student-#{student1.id}", "student-#{student2.id}"]
          }
        end

        it 'saves to db' do
          expect do
            gaku_js_post :enroll_students, attributes
          end.to change(Gaku::ClassGroupEnrollment, :count).by 2

          should respond_with(:success)
        end

      end

    end
  end


end
