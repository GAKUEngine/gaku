require 'spec_helper_models'

FactoryBot.factories.each do |factory|
  describe "Factory for :#{factory.name}" do
    if factory.name.to_s.include? 'invalid'
      it('is invalid') { build(factory.name).should be_invalid }
    elsif factory.name.to_s.include?('creation')
    else
      it('is valid') { build(factory.name).should be_valid }
    end
  end
end
