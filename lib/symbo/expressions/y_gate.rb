# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class YGate < Gate
    def matrix
      Matrix[[0, -1i], [1i, 0]]
    end
  end
end
