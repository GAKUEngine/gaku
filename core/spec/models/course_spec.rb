require 'spec_helper'

describe Gaku::Course do

  context "validations" do

    it_behaves_like 'notable'

    it { should have_many(:enrollments) }
    it { should have_many(:students).through(:enrollments) }
    it { should have_many(:course_group_enrollments) }
    it { should have_many(:course_groups).through(:course_group_enrollments) }
    it { should have_many(:exam_schedules) }
    it { should have_many(:class_group_course_enrollments) }
    it { should have_many(:class_groups).through(:class_group_course_enrollments) }


    it { should have_many :semester_courses }
    it { should have_many(:semesters).through(:semester_courses) }

    it { should belong_to(:syllabus) }
    it { should belong_to(:class_group) }

    it { should accept_nested_attributes_for(:enrollments) }

    it { should validate_presence_of :code }

    it { should allow_mass_assignment_of :code }
    it { should allow_mass_assignment_of :class_group_id }
    it { should allow_mass_assignment_of :syllabus_id }
  end

  context "enroll_class_group" do
  	it "should enroll class group to course" do
			course = create(:course)
			student1, student2 = create(:student), create(:student, :name => 'gaku')
      class_group = create(:class_group)
      create(:class_group_enrollment, :student_id => student1.id, :class_group_id => class_group.id)
      create(:class_group_enrollment, :student_id => student2.id, :class_group_id => class_group.id)
  		course.enroll_class_group(class_group)
  		course.student_ids.include?(student1.id)
  		course.student_ids.include?(student2.id)
  	end
  end

  context 'counter_cache' do

    let!(:course) { FactoryGirl.create(:course) }

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:course_with_note) { create(:course, :with_note) }

      it "increments notes_count" do
        expect do
          course.notes << note
        end.to change { course.reload.notes_count }.by 1
      end

      it "decrements notes_count" do
        expect do
          course_with_note.notes.last.destroy
        end.to change { course_with_note.reload.notes_count }.by -1
      end
    end

    context 'students_count' do

      let(:student) { build(:student) }
      let(:course_with_student) { create(:course, :with_student) }

      it "increments students_count" do
        expect do
          course.students << student
        end.to change { course.reload.students_count }.by 1
      end

      it "decrements students_count" do
        expect do
          course_with_student.students.last.destroy
        end.to change { course_with_student.reload.students_count }.by -1
      end
    end

  end

end
