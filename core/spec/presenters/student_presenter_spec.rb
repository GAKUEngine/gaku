require 'spec_helper'

describe Gaku::StudentPresenter do

  it "says when none given" do
    student = create(:student, :name => "John", :surname => "Doe")
    presenter = Gaku::StudentPresenter.new(Gaku::Student.new, view)
    presenter.website.should include("None given")
  end

end
