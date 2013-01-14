module Gaku
  module Notable
    extend ActiveSupport::Concern

    included do
      has_many :notes, as: :notable
    end

  end
end
