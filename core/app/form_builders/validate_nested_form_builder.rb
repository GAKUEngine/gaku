class ValidateNestedFormBuilder < ValidateFormBuilder
  require 'nested_form'
  include ::NestedForm::BuilderMixin
end
