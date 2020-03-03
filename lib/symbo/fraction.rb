# frozen_string_literal: true

require 'symbo/constant'

module Symbo
  # Symbo fraction computation
  class Fraction < Expression
    include Constant

    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (1/3).base # => UNDEFINED
    def base
      UNDEFINED
    end

    # べき指数
    #
    #   (1/3).exponent # => UNDEFINED
    def exponent
      UNDEFINED
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   (1/3).term # => UNDEFINED
    def term
      UNDEFINED
    end

    # 同類項の定数部分
    #
    #   (1/3).const # => UNDEFINED
    def const
      UNDEFINED
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が定数の場合
    # 大小関係で順序を決定
    #
    #   (1/2).compare(4) # => true
    #   (1/2).compare(5/2) # => true
    #
    # - それ以外の場合
    # 常に true
    #
    #   (1/2).compare(:x + :y) # => true
    #   (1/2).compare(:x * :y) # => true
    #   (1/2).compare(2**:x) # => true
    #   (1/2).compare(Factorial(2)) # => true
    #   (1/2).compare(Function(:f, :x)) # => true
    def compare(other)
      case other
      when Integer
        rational < other
      when Fraction
        rational < other.rational
      else
        true
      end
    end

    # :section:

    def positive?
      rational.positive?
    end

    def rational
      Rational operand(0), operand(1)
    end

    def numerator
      if operands.all?(&:integer?)
        rational.numerator
      else
        operand(0)
      end
    end

    def denominator
      if operands.all?(&:integer?)
        rational.denominator
      else
        operand(1)
      end
    end

    def evaluate
      if denominator.zero?
        UNDEFINED
      else
        self
      end
    end

    def simplify_rne_rec
      if denominator.zero?
        UNDEFINED
      else
        self
      end
    end

    # rubocop:disable Metrics/AbcSize
    def simplify_rational_number
      n = operand(0)
      d = operand(1)

      case [n, d]
      in Integer, Integer
        if (n % d).zero?
          n.div d
        else
          g = n.gcd(d)
          if d.positive?
            Fraction[n.div(g), d.div(g)]
          else
            Fraction[(-n).div(g), (-d).div(g)]
          end
        end
      in Complex, Integer
        real_mod = n.real % d
        imag_mod = n.imag % d
        if real_mod.zero? && imag_mod.zero?
          if n.imag.div(d).zero?
            n.real.div d
          else
            Complex(n.real.div(d), n.imag.div(d))
          end
        else
          gr = n.real.gcd(d)
          gi = n.imag.gcd(d)
          if gr == gi
            if d.positive?
              Fraction[Complex(n.real.div(gr), n.imag.div(gr)), d.div(gr)]
            else
              Fraction[Complex(-n.real.div(gr), -n.imag.div(gr)), -d.div(gr)]
            end
          else
            self
          end
        end
      else
        raise NotImplementedError, "Fraction#simplify_rational_number(#{n.inspect}/#{d.inspect})"
      end
    end
    # rubocop:enable Metrics/AbcSize

    def negative?
      false
    end

    def to_s
      "#{operand(0)}/#{operand(1)}"
    end

    protected

    def _simplify
      return UNDEFINED if operand(1).zero?

      simplify_rational_number
    end
  end
end
