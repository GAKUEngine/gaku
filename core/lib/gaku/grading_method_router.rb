module Gaku
  class GradingMethodRouter

    @@grading_methods = { score:       Gaku::GradingMethods::Score,
        percentage:  Gaku::GradingMethods::Percentage,
        ordinal:     Gaku::GradingMethods::Ordinal,
        interval:    Gaku::GradingMethods::Interval,
        ratio:       Gaku::GradingMethods::Ratio,
        pass_fail:   Gaku::GradingMethods::PassFail
    }

    def self.grading_methods
      @@grading_methods
    end

    def self.get_class(method_symbol)
      if @@grading_methods[method_symbol].present? then
        return @@grading_methods[method_symbol]
      end

      return @@grading_methods[:score] # fallback to score - always safe
    end

    def self.get_instance(method_symbol, gradable, students, criteria)
      if @@grading_methods[method_symbol].present? then
        return @@grading_methods[method_symbol].new(gradable, students, cirteria)
      end

      return @@grading_methods[:score].new(gradable, students, criteria) # fallback to score - always safe
    end
  end
end
