require 'spec_helper'

describe CourseEnrollmentsController do
	let(:student) {Factory(:student)}
	let(:course)  {Factory(:course)}

	describe 'POST :enroll_student' do
	  it "should create new course enrollment" do
	  	expect do
	  		post :enroll_student, :course_enrollment => {:student_id => student.id, :course_id => course.id}
	  	end.to change(CourseEnrollment, :count).by(1)
	  end
	end	

	describe 'POST :create' do
	  it "should create new course enrollment (from student side)" do
	  	expect do
	  		post :create, :course_enrollment => {:student_id => student.id, :course_id => course.id}
	  	end.to change(CourseEnrollment, :count).by(1)
	  end
	end


end
