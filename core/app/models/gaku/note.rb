module Gaku
	class Note < ActiveRecord::Base
	  belongs_to :notable, polymorphic: true, counter_cache: true

	  attr_accessible :title, :content

    validates_presence_of :title, :content
	end
end
