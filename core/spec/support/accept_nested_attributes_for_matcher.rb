  # Use: it { should accept_nested_attributes_for(:association_name).and_accept({valid_values => true}).but_reject({ :reject_if_nil => nil })}
  RSpec::Matchers.define :accept_nested_attributes_for do |association|
    match do |model|
      @model = model
      @nested_att_present = model.respond_to?("#{association}_attributes=".to_sym)
      if @nested_att_present && @reject
        model.send("#{association}_attributes=".to_sym,[@reject])
        @reject_success = model.send("#{association}").empty?
      end
      if @nested_att_present && @accept
        model.send("#{association}_attributes=".to_sym,[@accept])
        @accept_success = ! (model.send("#{association}").empty?)
      end
      @nested_att_present && ( @reject.nil? || @reject_success ) && ( @accept.nil? || @accept_success )
    end

    failure_message_for_should do
      messages = []
      messages << "expected #{@model.class} to accept nested attributes for #{association}" unless @nested_att_present
      messages << "expected #{@model.class} to reject values #{@reject.inspect} for association #{association}" unless @reject_success
      messages << "expected #{@model.class} to accept values #{@accept.inspect} for association #{association}" unless @accept_success
      messages.join(", ")
    end

    description do
      desc = "accept nested attributes for #{expected}"
      if @reject
        desc << ", but reject if attributes are #{@reject.inspect}"
      end
    end

    chain :but_reject do |reject|
      @reject = reject
    end

    chain :and_accept do |accept|
      @accept = accept
    end
  end