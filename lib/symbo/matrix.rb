# frozen_string_literal: true

require 'matrix'

module Symbo
  # シンボリック演算を使う行列
  refine Matrix do
    alias_method :mult, :*

    def *(other)
      if other.respond_to?(:to_matrix)
        (mult other.to_matrix).simplify
      else
        mult other
      end
    end

    def simplify
      map(&:simplify)
    end
  end
end
