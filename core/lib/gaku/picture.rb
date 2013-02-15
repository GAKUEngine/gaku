module Gaku
  module Picture
    extend ActiveSupport::Concern

    included do
      has_attached_file :picture, :styles => {:thumb => "256x256>"}, :default_url => "/assets/pictures/thumb/missing.png"
      attr_accessible :picture
    end

  end
end
