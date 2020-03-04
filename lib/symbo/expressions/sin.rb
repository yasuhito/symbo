# frozen_string_literal: true

require 'symbo/expressions/trigonometric_function'

module Symbo
  class Sin < TrigonometricFunction
    using Symbo

    def self.[](x) # rubocop:disable Naming/MethodParameterName
      new(x)
    end

    def initialize(x) # rubocop:disable Naming/MethodParameterName
      super :sin, x
    end

    def to_s
      "cos(#{operand(1)})"
    end

    protected

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def _simplify
      if x.zero?
        0
      elsif x == PI
        0
      elsif x.constant? && x.negative?
        (-Sin[Product[-1, x].simplify]).simplify
      elsif x.product? && x.operand(0).integer? && x.operand(0).negative?
        (-Sin[Product[-1, x.operand(0), *x.operands[1..-1]].simplify]).simplify
      elsif kn_pi?
        simplify_kn_pi.simplify
      else
        self
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity

    private

    # Simplification of sin(kπ/n)
    #
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    def simplify_kn_pi
      k = x.operand(0).numerator
      n = x.operand(0).denominator

      case n
      when 1
        0
      when 2
        case k % 4
        when 1
          1
        when 3
          -1
        end
      when 3
        case k % 6
        when 1, 2
          √(3)/2
        when 4, 5
          Product[-1, √(3)/2]
        end
      when 4
        case k % 8
        when 1, 3
          1/√(2)
        when 5, 7
          -1/√(2)
        end
      when 6
        case k % 12
        when 1, 5
          1/2
        when 7, 11
          -1/2
        end
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
