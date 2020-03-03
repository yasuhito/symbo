# frozen_string_literal: true

require 'symbo/constant'
require 'symbo/expression_type'

module Symbo
  refine Complex do
    include AlgebraicOperators
    include ExpressionType
    include Constant

    def simplify
      dup
    end

    def evaluate
      dup
    end

    def simplify_rational_number
      dup
    end

    def simplify_rne_rec
      dup
    end

    def base
      UNDEFINED
    end

    def compare(other)
      case other
      when Integer
        false
      when Symbol
        other == PI
      else
        true
      end
    end

    def to_s
      if real.zero?
        if imag == 1
          'i'
        else
          "#{imag}i"
        end
      elsif imag == 1
        "(#{real} + i)"
      else
        "(#{real} + #{imag}i)"
      end
    end
  end
end

# Matrix などの中で使われる Complex#+ などをハイジャック
class Complex
  include Symbo::Constant
  include Symbo::ExpressionType

  alias plus +
  alias mult *

  def +(other)
    plus other
  rescue TypeError
    Symbo::Sum[self, other]
  end

  def *(other)
    mult other
  rescue TypeError
    Symbo::Product[self, other]
  end
end
