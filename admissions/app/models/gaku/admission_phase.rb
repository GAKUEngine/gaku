module Gaku
  class AdmissionPhase < ActiveRecord::Base
    attr_accessible :name, :order, :phase_handler
  end
end