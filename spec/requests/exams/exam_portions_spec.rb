require 'spec_helper'

describe 'Exam portions' do
  stub_authorization!

  context 'exam/show' do
    before do
      @exam = Factory(:exam, :name => "Linux")
      visit exam_path(@exam)
      Exam.count.should == 1
    end

    pending 'should add a portion' do
    end

  end
end