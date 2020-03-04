# frozen_string_literal: true

require 'symbo/expressions/fraction'
require 'symbo/operators/power'

module Symbo
  class Sqrt
    def self.[](x) # rubocop:disable Naming/MethodParameterName
      Symbo::Power[x, Symbo::Fraction[1, 2]]
    end
  end

  def √(x) # rubocop:disable Naming/MethodName, Naming/BinaryOperatorParameterName, Naming/MethodParameterName
    Sqrt[x]
  end
end
