module Gaku
  class Note < ActiveRecord::Base
    belongs_to :notable, polymorphic: true, counter_cache: true, required: false

    validates :title, :content, presence: true
  end
end
