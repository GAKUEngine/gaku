require 'spec_helper'

describe Gaku::StudentPresenter do

  xit "says when none given" do
    student = create(:student, :name => "John", :surname => "Doe")
    presenter = Gaku::StudentPresenter.new(Gaku::Student.new, view)
    presenter.website.should include("None given")
  end

end
