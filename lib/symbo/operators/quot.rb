# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  class Quot < Expression
    using Symbo

    def evaluate
      if w.numerator.zero?
        UNDEFINED
      else
        # v = vn/vd, w = wn/wd とすると
        # v/w = Quot(vn/vd, wn/wd).evaluate = vn·wd / wn·vd
        Fraction[v.numerator.mult(w.denominator), w.numerator.mult(v.denominator)]
      end
    end

    protected

    def _simplify
      Product[operand(0), Power[operand(1), -1]].simplify
    end

    private

    # an integer or a fraction with non-zero denominator
    def v
      @v ||= operand(0).evaluate
    end

    # an integer or a fraction with non-zero denominator
    def w
      @w ||= operand(1).evaluate
    end
  end
end
