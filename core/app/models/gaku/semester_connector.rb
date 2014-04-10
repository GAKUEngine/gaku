module Gaku
  class SemesterConnector < ActiveRecord::Base

    belongs_to :semester
    belongs_to :semesterable, polymorphic: true

    validates :semester_id,
      uniqueness: {
                    scope: [ :semesterable_type, :semesterable_id ],
                    message: I18n.t(:'semester.already')
                  }

    validates :semester_id, :semesterable_type, :semesterable_id, presence: true

    validates :semesterable_type,
      inclusion: {
        in: %w(Gaku::ClassGroup Gaku::Course),
        message: "%{value} is not a valid"
      }

    %w( course class_group ).each do |resource|
      self.define_singleton_method "group_by_semester_#{resource}" do
        where(semesterable_type: extract_model_name(resource)).includes([:semester, :semesterable]).group_by(&:semester_id)
      end
    end

    private

    def self.extract_model_name(resource)
      resource.insert(0, 'gaku/').classify
    end

  end
end
