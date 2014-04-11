module Notes
  extend ActiveSupport::Concern

  included do
    has_many :notes, as: :notable
  end
end

