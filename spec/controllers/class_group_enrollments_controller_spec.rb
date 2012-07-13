require 'spec_helper'

describe ClassGroupEnrollmentsController do
	before(:each) do
	  login_admin
	end

	describe "POST :create" do
	  let(:student) {Factory.create(:student)}
		let(:class_group) {Factory.create(:class_group)}

	  it "should create new class group enrollment with ajax" do
	    expect do
		    xhr :post, :create, :student_id => student.id, :class_group_id => class_group.id, :seat_number => 22 
	  	end.to change(ClassGroupEnrollment,:count).by(1)
	  end
	end
 

end