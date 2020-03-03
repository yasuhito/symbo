# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # シンボリックなべき乗
  class Power < Expression
    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (:x**2).base # => :x
    def base
      @operands[0]
    end

    # べき指数
    #
    #   (:x**2).exponent # => 2
    def exponent
      @operands[1]
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   (:x**2).term # => Product(:x**2)
    def term
      Product[self]
    end

    # 同類項の定数部分
    #
    #   (:x**2).const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手がべき乗の場合
    # 底が異なる場合、底同士で順序を決める。
    # 底が等しい場合、べき指数同士で順序を決める。
    #
    #   ((1 + :x)**3).compare((1 + :y)**2) # => true
    #   ((1 + :x)**2).compare((1 + :x)**3) # => true
    #
    # - 和、階乗、関数、シンボルの場合
    # 相手を 1 乗のべき乗に変換して比較
    #
    #   ((1 + :x)**3).compare(1 + :y) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    def compare(other)
      case other
      when Power
        return base.compare(other.base) if base != other.base

        exponent.compare other.exponent
      when Sum, Factorial, Function, Symbol
        compare Power[other, 1]
      else
        !other.compare(self)
      end
    end

    # :section: Evaluation Methods

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    def evaluate
      raise unless base.constant?
      raise unless exponent.integer?

      if base.numerator != 0
        if exponent.positive?
          Product[Power[base, exponent - 1].evaluate, base].evaluate
        elsif exponent.zero?
          1
        elsif exponent == -1
          Fraction[1, base]
        elsif exponent < -1
          raise NotImplementedError
        end
      elsif base.numerator.zero?
        if n >= 1
          0
        else
          UNDEFINED
        end
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize

    def to_s
      "#{base}^(#{exponent})"
    end

    protected

    # :section: Simplification Methods

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    def _simplify
      return UNDEFINED if base == UNDEFINED || exponent == UNDEFINED

      if base.zero?
        return 1 if exponent.positive? && exponent.constant?

        return UNDEFINED
      end

      return 1 if base == 1
      return simplify_integer_power if exponent.integer?
      return simplify_eulers_formula if base == E

      self
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize

    # rubocop:disable Metrics/CyclomaticComplexity
    def simplify_integer_power
      return Power[base, exponent].simplify_rne if base.constant?
      return 1 if exponent.zero?
      return base if exponent == 1

      case base
      when Power
        r = base.operands[0]
        s = base.operands[1]
        p = Product.new(s, exponent).simplify

        if p.integer?
          Power[r, p].simplify_integer_power
        else
          Power[r, p]
        end
      when Product
        r = base.operands.map { |each| Power[each, exponent].simplify_integer_power }
        Product[*r].simplify
      else
        self
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    # e^ix = cos(x) + sin(x)
    #
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def simplify_eulers_formula
      if exponent.product? &&
         exponent.operand(0).is_a?(Complex) && exponent.operand(0).real.zero? &&
         exponent.operand(1) == PI
        # eg e^{ki * π}
        x = Product[exponent.operand(0).imag, exponent.operand(1)]
        (Cos[x] + 1i * Sin[x]).simplify
      elsif exponent.product? &&
            exponent.operand(0).fraction? && exponent.operand(0).operand(0).is_a?(Complex) && exponent.operand(0).operand(0).real.zero? &&
            exponent.operand(1) == PI
        # eg e^{(k/n)i * π}
        x = Product[Fraction[exponent.operand(0).operand(0).imag, exponent.operand(0).operand(1)], exponent.operand(1)]
        (Cos[x] + 1i * Sin[x]).simplify
      else
        self
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def simplify_rne_rec
      v = base.simplify_rne_rec
      if v == UNDEFINED
        UNDEFINED
      else
        Power[v, exponent].evaluate
      end
    end
  end
end
