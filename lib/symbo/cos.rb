# frozen_string_literal: true

require 'symbo/trigonometric_function'

module Symbo
  class Cos < TrigonometricFunction
    using Symbo

    def self.[](x) # rubocop:disable Naming/MethodParameterName
      new(x)
    end

    def initialize(x) # rubocop:disable Naming/MethodParameterName
      super :cos, x
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
        1
      elsif x == PI
        -1
      elsif x.constant? && x.negative?
        Cos[Product[-1, x].simplify].simplify
      elsif x.product? && x.operand(0).integer? && x.operand(0).negative?
        Cos[Product[-1, x.operand(0), *x.operands[1..-1]].simplify].simplify
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

    # rubocop:disable Metrics/AbcSize
    def kn_pi?
      x.product? && x.length == 2 && x.operand(0).constant? && x.operand(1) == PI &&
        [1, 2, 3, 4, 6].include?(x.operand(0).denominator) && x.operand(0).numerator.integer?
    end
    # rubocop:enable Metrics/AbcSize

    # Simplification of cos(kπ/n)
    #
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def simplify_kn_pi
      k = x.operand(0).numerator
      n = x.operand(0).denominator

      case n
      when 1
        case k % 2
        when 0
          1
        end
      when 2
        case k % 2
        when 1
          0
        end
      when 3
        case k % 6
        when 1, 5
          1/2
        when 2, 4
          -1/2
        end
      when 4
        case k % 8
        when 1, 7
          1/√(2)
        when 3, 5
          -1/√(2)
        end
      when 6
        case k % 12
        when 1, 11
          √(3)/2
        when 5, 7
          Product[-1, √(3)/2]
        end
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
