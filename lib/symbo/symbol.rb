# frozen_string_literal: true

require 'symbo/algebraic_operators'
require 'symbo/expression_type'
require 'symbo/relational_operators'

module Symbo
  refine Symbol do
    include AlgebraicOperators
    include ExpressionType
    include RelationalOperators

    # :section: Simplification Methods

    def simplify
      self
    end

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   :x.base # => :x
    def base
      self
    end

    # べき指数
    #
    #   :x.exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   :x.term # => Product[:x]
    def term
      Product[self]
    end

    # 同類項の定数部分
    #
    #   :x.const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手がシンボルの場合
    # 辞書順で順序を決定
    #
    #   :a.compare(:b) # => true
    #   :A.compare(:a) # => true
    #   :v1.compare(:v2) # => true
    #   :x1.compare(:xa) # => true
    #
    # - それ以外の場合
    #   :x.compare(:x**2) # => true
    #   :x.compare(Function(:x, :t)) # => true
    #   :x.compare(Function(:y, :t)) # => true
    def compare(other)
      if other.is_a?(Symbol)
        if self == :π
          -1
        else
          self < other
        end
      else
        !other.compare(self)
      end
    end

    # :section: Relational Operator Methods

    def ==(other)
      other.is_a?(Symbol) && to_s == other.to_s
    end

    # :category: Simplification Methods

    def simplify_rational_number
      raise unless self == UNDEFINED

      UNDEFINED
    end
  end
end

# Matrix などの中で使われる Symbol#+ などをハイジャック
class Symbol
  include Symbo::ExpressionType

  def +(other)
    Symbo::Sum[self, other]
  end
end
