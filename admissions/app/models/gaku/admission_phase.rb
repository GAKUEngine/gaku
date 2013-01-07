module Gaku
  class AdmissionPhase < ActiveRecord::Base

    belongs_to :admission_method
  	has_many :admission_phase_records
    has_many :exams
  	has_many :admission_phase_states
    accepts_nested_attributes_for :admission_phase_states, :allow_destroy => true
    has_one  :exam

    attr_accessible :name, :position, :phase_handler, :admission_method_id, :admission_phase_states_attributes

    validates :name, presence: true
    validates :admission_method, presence: true

    before_create :proper_position
    after_destroy :refresh_positions

    private

    def proper_position
      self.position = self.admission_method.admission_phases.count
    end

    def refresh_positions
      admission_phases = self.admission_method.admission_phases
      admission_phases.pluck(:id).each_with_index do |id, index|
        admission_phases.update_all( {:position => index}, {:id => id} )
      end
    end

  end
end