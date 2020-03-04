# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class HGate < Gate
    using Symbo

    def matrix
      Matrix[[1/√(2), 1/√(2)],
             [1/√(2), -1/√(2)]]
    end
  end
end
