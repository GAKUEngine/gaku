module Gaku
  class AdmissionPhaseState < ActiveRecord::Base
    attr_accessible :name, :can_progress, :can_admit, :auto_admit
  end
end