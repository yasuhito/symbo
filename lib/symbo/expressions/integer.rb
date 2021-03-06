# frozen_string_literal: true

require 'symbo/expressions/concerns/algebraic_operators'
require 'symbo/expressions/concerns/constant'
require 'symbo/expressions/concerns/expression_type'

module Symbo
  refine Integer do
    alias_method :mult, :*
    alias_method :div, :/
    alias_method :pow, :**

    include AlgebraicOperators
    include Constant
    include ExpressionType

    def simplify
      self
    end

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   1.base # => UNDEFINED
    def base
      UNDEFINED
    end

    # べき指数
    #
    #   1.exponent # => UNDEFINED
    def exponent
      UNDEFINED
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   1.term # => UNDEFINED
    def term
      UNDEFINED
    end

    # 同類項の定数部分
    #
    #   1.const # => UNDEFINED
    def const
      UNDEFINED
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が定数の場合
    # 大小関係で順序を決定
    #
    #   2.compare(4) # => true
    #   2.compare(5/2) # => true
    #
    # - それ以外の場合
    # 常に true
    #
    #   2.compare(:x + :y) # => true
    #   2.compare(:x * :y) # => true
    #   2.compare(2**:x) # => true
    #   2.compare(Factorial(2)) # => true
    #   2.compare(Function(:f, :x)) # => true
    def compare(other)
      case other
      when Integer
        self < other
      when Fraction
        self < other.rational
      else
        true
      end
    end

    # :section:

    def numerator
      self
    end

    def denominator
      1
    end

    def evaluate
      self
    end

    def simplify_rational_number
      self
    end

    def simplify_rne_rec
      self
    end
  end
end
