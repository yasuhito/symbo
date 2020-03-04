# frozen_string_literal: true

require 'symbo/concerns/algebraic_operators'
require 'symbo/concerns/constant'
require 'symbo/concerns/expression_type'

module Symbo
  refine Complex do
    include AlgebraicOperators
    include Constant
    include ExpressionType

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
