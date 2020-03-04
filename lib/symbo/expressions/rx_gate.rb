# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class RxGate < Gate
    using Symbo

    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[Cos[@theta/2], -1i * Sin[@theta/2]],
             [-1i * Sin[@theta/2], Cos[@theta/2]]]
    end
  end
end
