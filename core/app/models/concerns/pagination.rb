module Pagination
  extend ActiveSupport::Concern

  included do
    paginates_per 20
  end
end

