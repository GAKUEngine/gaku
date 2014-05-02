require 'spec_helper'

describe 'Extracurricular Activity Enrollments' do

  let!(:extracurricular_activity) { create(:extracurricular_activity) }
  let!(:student) { create(:student) }
  let(:student2) { create(:student) }

  before { as :admin }

  describe 'XHR GET :new' do
    before { get "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/new", format: :js }

    it('is successful') { expect(response.code).to eq '200' }
    it('renders :new template') { template? :new }
    it('assigns @enrollmentable') { expect(assigns(:enrollmentable)).to eq extracurricular_activity }

    it('assigns @enrollmentable_resource') do
      expect(assigns(:enrollmentable_resource)).to eq 'extracurricular-activity'
    end

    it('assigns @students') { expect(assigns(:students)).to eq [student] }
  end

  describe 'XHR GET :student_selection' do
    before do
      get "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/student_selection", format: :js
    end

    it('is successful') { expect(response.code).to eq '200' }
    it('renders :student_selection template') { template? :student_selection }
    it('assigns @enrollmentable') { expect(assigns(:enrollmentable)).to eq extracurricular_activity }

    it('assigns @enrollmentable_resource') do
      expect(assigns(:enrollmentable_resource)).to eq 'extracurricular-activity'
    end

    it('assigns @enrollment') { expect(assigns(:enrollment)).to be_a_new Gaku::Enrollment }
    it('assigns @student_selection') { expect(assigns(:student_selection)).to_not be_nil }
  end

  describe 'XHR POST #create' do
    context 'with valid attributes' do
      let(:subject) do
        post "/extracurricular_activities/#{extracurricular_activity.id}/enrollments",
             format: :js,
             enrollment: { student_id: student.id }
      end

      it('is successful') { expect(subject).to eq 200 }
      it('creates new enrollment') { expect { subject }.to change(Gaku::Enrollment, :count).by(1) }

      it 'renders :create template' do
        subject
        template? :create
      end

      it 'renders flash' do
        subject
        flash_created?
      end

      it 'increments @count' do
        subject
        expect(assigns(:count)).to eq 1
      end

      it 'assigns @enrollmentable' do
        subject
        expect(assigns(:enrollmentable)).to eq extracurricular_activity
      end

      it 'assigns @enrollmentable_resource' do
        subject
        expect(assigns(:enrollmentable_resource)).to eq 'extracurricular-activity'
      end
    end
  end

  describe 'XHR POST #create_from_selection' do
    context 'with valid student' do
      let(:subject) do
        post "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/create_from_selection",
             format: :js , selected_students: ["#{student.id}", "#{student2.id}"]
      end

      it('is successful') { expect(subject).to eq 200 }
      it('creates new enrollment') { expect { subject }.to change(Gaku::Enrollment, :count).by(2) }

      it 'renders :create template' do
        subject
        template? :create_from_selection
      end

      it 'renders flash[:success]' do
        subject
        expect(flash[:success]).to include "#{student.decorate.full_name}"
        expect(flash[:success]).to include "#{student2.decorate.full_name}"
        expect(flash[:success]).to include 'Successfully enrolled!'
      end

      it 'increments @count' do
        subject
        expect(assigns(:count)).to eq 2
      end
    end

    context 'with invalid student' do
      subject do
        post "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/create_from_selection",
             format: :js,
             selected_students: ['666666']
      end

      it('is successful') { expect(subject).to eq 200 }
      it("doesn't create new enrollment") { expect { subject }.to_not change(Gaku::Enrollment, :count) }

      it 'renders :create template' do
        subject
        template? :create_from_selection
      end

      it 'renders flash[:error]' do
        subject
        expect(flash[:error]).to eq 'Students with ids: 666666 not found'
      end

      it "doesn't renders flash[:success]" do
        subject
        expect(flash[:success]).to be_nil
      end

      it "doesn't increment @count" do
        subject
        expect(assigns(:count)).to eq 0
      end
    end

    context 'with duplicated student' do
      subject do
        post "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/create_from_selection",
             format: :js,
             selected_students: ["#{student.id}", "#{student2.id}"]
      end

      before { extracurricular_activity.students << student }

      it('is successful') { expect(subject).to eq 200 }
      it('creates new enrollment') { expect { subject }.to change(Gaku::Enrollment, :count).by(1) }

      it 'renders :create template' do
        subject
        template? :create_from_selection
      end

      it 'renders flash[:error]' do
        subject
        expect(flash[:error]).to include "#{student.decorate.full_name}"
        expect(flash[:error]).to include 'already enrolled!'
      end

      it 'renders flash[:success]' do
        subject
        expect(flash[:success]).to include "#{student2.decorate.full_name}"
        expect(flash[:success]).to include 'Successfully enrolled!'
      end

      it 'increments @count' do
        subject
        expect(assigns(:count)).to eq 2
      end
    end

    context 'with valid and invalid student' do
      subject do
        post "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/create_from_selection",
             format: :js,
             selected_students: ["#{student.id}", '666666']
      end

      it('is successful') { expect(subject).to eq 200 }
      it('creates new enrollment') { expect { subject }.to change(Gaku::Enrollment, :count).by(1) }

      it 'renders :create template' do
        subject
        template? :create_from_selection
      end

      it 'renders flash[:error]' do
        subject
        expect(flash[:error]).to eq 'Students with ids: 666666 not found'
      end

      it 'renders flash[:success]' do
        subject
        expect(flash[:success]).to include "#{student.decorate.full_name}"
        expect(flash[:success]).to include 'Successfully enrolled!'
      end

      it 'increments @count' do
        subject
        expect(assigns(:count)).to eq 1
      end
    end

    context 'without :selected_students params' do
      subject do
        post "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/create_from_selection",
             format: :js
      end

      it('is successful') { expect(subject).to eq 302 }
      it("doesn't create new enrollment") { expect { subject }.to_not change(Gaku::Enrollment, :count) }

      it 'redirects' do
        subject
        redirect_to? "/extracurricular_activities/#{extracurricular_activity.id}/enrollments"
      end

      it 'renders flash[:error]' do
        subject
        expect(flash[:error]).to eq 'No students selected!'
      end

      it 'sets @count' do
        subject
        expect(assigns(:count)).to eq 0
      end
    end

  end

  describe 'XHR DELETE #destroy' do

    let(:enrollment) { create(:extracurricular_activity_enrollment) }
    subject do
      delete "/extracurricular_activities/#{extracurricular_activity.id}/enrollments/#{enrollment.id}", format: :js
    end

    it 'deletes enrollment' do
      enrollment
      expect do
        subject
      end.to change(Gaku::Enrollment, :count).by(-1)
    end

    it 'decrements @count' do
      subject
      expect(assigns(:count)).to eq 0
    end

    it 'sets flash' do
      subject
      flash_destroyed?
    end
  end

end
