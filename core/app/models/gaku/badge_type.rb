module Gaku
  class BadgeType < ActiveRecord::Base
    has_many :badges
    has_many :students, through: :badges

    has_attached_file :badge_image, default_url: ':placeholder'

    validates :name, presence: true

    def to_s
      name
    end
  end
end
