require 'spec_helper'

describe Gaku::Student do

  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant, id:1) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted, id:2) }

  context "validations" do
    it { should have_one(:admission) }
    #it { should validate_presence_of(:enrollment_status_id) }
  end

  context 'when student is applicant' do
        
    before do
      @student = create(:student, enrollment_status_id:1)
    end

    xit 'shows only applicants' do
      expect(Gaku::Student.only_applicants).to eq [@student]  
    end

    it 'makes the applicant student' do
      @student.make_admitted(Date.today)
      expect(@student.enrollment_status.code).to eq 'admitted'
      expect(@student.admitted).not_to be_nil
    end

  end

  context 'when student is admitted' do
    
    before do
      @student = create(:student, enrollment_status_id:2)
    end

    xit "has named scope :only_applicants" do
      #assert Gaku::Student.respond_to?(:only_applicants)
      expect(Gaku::Student.only_applicants).to eq []
    end 

    it 'makes the student applicant' do
      @student.make_applicant
      expect(@student.enrollment_status.code).to eq 'applicant'
    end

  end
end
