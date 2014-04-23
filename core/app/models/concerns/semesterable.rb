module Semesterable
  extend ActiveSupport::Concern

  included do
    has_many :semester_connectors, as: :semesterable, dependent: :destroy
    has_many :semesters, through: :semester_connectors, source: :semester

    scope :without_semester, -> {
                                  includes(:semester_connectors)
                                  .where(gaku_semester_connectors: { semesterable_id: nil })
                                }

  end

end
