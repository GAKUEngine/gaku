module Globalize
  module  ActiveRecord
    Translation.class_eval do
      attr_accessible :locale
    end
  end
end
