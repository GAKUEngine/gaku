module Gaku
  class GradingMethodRouter
    attr_reader :methods 

    def initialize
      @methods = { score:       Gaku::GradingMethods::Score,
                   percentage:  Gaku::GradingMethods::Percentage,
                   ordinal:     Gaku::GradingMethods::Ordinal,
                   interval:    Gaku::GradingMethods::Interval,
                   ratio:       Gaku::GradingMethods::Ratio,
                   pass_fail:   Gaku::GradingMethods::PassFail
      }
    end

    def get_class(method_symbol)
      return @methods[method_symbol] if @methods[method_symbol].present?
      return @methods[:score] # fallback to score - always safe
    end

    def get_instance(method_symbol, gradable, students, criteria)
      return @methods[method_symbol].new(gradable, students, cirteria) if @methods[method_symbol].present?
      return @methods[:score].new(gradable, students, criteria) # fallback to score - always safe
    end
  end
end
